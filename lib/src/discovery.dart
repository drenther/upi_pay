import 'dart:convert';

import 'package:universal_io/io.dart' as io;
import 'package:upi_pay/src/platform_interface.dart';
import 'package:upi_pay/types/applications.dart';
import 'package:upi_pay/types/discovery.dart';
import 'package:upi_pay/types/status.dart';
import 'package:upi_pay/types/meta.dart';

class UpiApplicationDiscovery implements _PlatformDiscoveryBase {
  final discovery = io.Platform.isAndroid
      ? _AndroidDiscovery()
      : io.Platform.isIOS
          ? _IosDiscovery()
          : null;
  static final _singleton = UpiApplicationDiscovery._inner();
  factory UpiApplicationDiscovery() {
    return _singleton;
  }
  UpiApplicationDiscovery._inner();

  @override
  Future<List<ApplicationMeta>> discover({
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType =
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType =
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    if (!(io.Platform.isAndroid || io.Platform.isIOS)) {
      throw UnsupportedError('Discovery is available only on Android and iOS');
    }
    return discovery!.discover(
      applicationStatusMap: applicationStatusMap,
      paymentType: paymentType,
      statusType: statusType,
    );
  }
}

class _AndroidDiscovery implements _PlatformDiscoveryBase {
  static final _singleton = _AndroidDiscovery._inner();
  factory _AndroidDiscovery() {
    return _singleton;
  }
  _AndroidDiscovery._inner();

  @override
  Future<List<ApplicationMeta>> discover({
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType =
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType =
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    final appsList = await UpiPayPlatform.instance.getInstalledUpiApps();
    if (appsList == null) return [];
    final List<ApplicationMeta> retList = [];
    appsList.forEach((app) {
      final packageName = _castToString(app['packageName']);
      final androidStatus = _getStatus(packageName, applicationStatusMap);
      if (androidStatus == null) {
        return null;
      }
      if (_canUseApp(statusType, androidStatus)) {
        final icon = _castToString(app['icon']);
        final priority = _castToInt(app['priority']);
        final preferredOrder = _castToInt(app['preferredOrder']);
        retList.add(ApplicationMeta.android(
          UpiApplication.lookUpMap[packageName]!,
          base64.decode(icon),
          priority,
          preferredOrder,
        ));
      }
    });
    return retList;
  }

  UpiApplicationAndroidStatus? _getStatus(String packageName,
      Map<UpiApplication, UpiApplicationStatus> applicationStatusMap) {
    if (!UpiApplication.lookUpMap.containsKey(packageName)) {
      return null;
    }
    final upiApp = UpiApplication.lookUpMap[packageName];
    if (!applicationStatusMap.containsKey(upiApp)) {
      return null;
    }
    final status = applicationStatusMap[upiApp]!;
    return status.androidStatus;
  }

  bool _canUseApp(UpiApplicationDiscoveryAppStatusType statusType,
      UpiApplicationAndroidStatus androidStatus) {
    if (androidStatus.setup == UpiApplicationSetupStatus.success &&
        androidStatus.linkingSupport == UpiApplicationLinkingSupport.shows) {
      switch (statusType) {
        case UpiApplicationDiscoveryAppStatusType.working:
          return androidStatus.nonMerchantPaymentStatus ==
                  NonMerchantPaymentAndroidStatus.success &&
              !androidStatus.warnsUnverifiedSourceForNonMerchant;
        case UpiApplicationDiscoveryAppStatusType.workingWithWarnings:
          return androidStatus.nonMerchantPaymentStatus ==
              NonMerchantPaymentAndroidStatus.success;
        case UpiApplicationDiscoveryAppStatusType.all:
          return true;
      }
    }
    return false;
  }
}

class _IosDiscovery implements _PlatformDiscoveryBase {
  static final _singleton = _IosDiscovery._inner();
  factory _IosDiscovery() {
    return _singleton;
  }
  _IosDiscovery._inner();

  @override
  Future<List<ApplicationMeta>> discover({
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType =
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType =
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    Map<String, UpiApplication> discoveryMap = {};
    List<UpiApplication> discovered = [];
    applicationStatusMap.forEach((app, status) {
      if (app.iosBundleId == null) return;
      final iosStatus = _getStatus(app.iosBundleId!, applicationStatusMap);
      if (iosStatus != null && _canUseApp(statusType, iosStatus)) {
        if (app.discoveryCustomScheme != null) {
          discoveryMap[app.discoveryCustomScheme!] = app;
        } else {
          discovered.add(app);
        }
      }
    });
    final keys = discoveryMap.keys.toList();
    for (int idx = 0; idx < discoveryMap.length; ++idx) {
      final scheme = keys[idx];
      try {
        final bool? result = await UpiPayPlatform.instance.canLaunch(scheme);
        // print('$scheme, launch-able: $result');
        if (result == true) {
          discovered.add(discoveryMap[scheme]!);
        }
      } catch (error, stack) {
        // print('$scheme canLaunch error');
        print(error);
        print(stack);
      }
    }
    return discovered.map((app) => ApplicationMeta.ios(app)).toList();
  }

  UpiApplicationIosStatus? _getStatus(String packageName,
      Map<UpiApplication, UpiApplicationStatus> applicationStatusMap) {
    if (!UpiApplication.lookUpMap.containsKey(packageName)) {
      return null;
    }
    final upiApp = UpiApplication.lookUpMap[packageName]!;
    if (!applicationStatusMap.containsKey(upiApp)) {
      return null;
    }
    final status = applicationStatusMap[upiApp]!;
    if (status.iosStatus == null) {
      return null;
    }
    return status.iosStatus;
  }

  bool _canUseApp(UpiApplicationDiscoveryAppStatusType statusType,
      UpiApplicationIosStatus iosStatus) {
    if (iosStatus.setup == UpiApplicationSetupStatus.success &&
        iosStatus.linkingSupport == UpiApplicationLinkingSupport.shows) {
      switch (statusType) {
        case UpiApplicationDiscoveryAppStatusType.working:
          return iosStatus.nonMerchantPaymentStatus ==
                  NonMerchantPaymentIosStatus.success &&
              !iosStatus.warnsUnverifiedSourceForNonMerchant;
        case UpiApplicationDiscoveryAppStatusType.workingWithWarnings:
          return iosStatus.nonMerchantPaymentStatus ==
              NonMerchantPaymentIosStatus.success;
        case UpiApplicationDiscoveryAppStatusType.all:
          return true;
      }
    }
    return false;
  }
}

abstract class _PlatformDiscoveryBase {
  Future<List<ApplicationMeta>> discover({
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType =
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType =
        UpiApplicationDiscoveryAppStatusType.working,
  });
}

String _castToString(dynamic val) {
  if (val is String) {
    return val;
  }
  throw TypeError();
}

int _castToInt(dynamic val) {
  if (val is int) {
    return val;
  }
  throw TypeError();
}
