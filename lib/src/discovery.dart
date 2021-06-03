import 'dart:convert';

import 'package:universal_io/io.dart' as io;
import 'package:upi_pay/src/applications.dart';
import 'package:upi_pay/src/method_channel.dart';
import 'package:upi_pay/src/status.dart';
import 'package:upi_pay/src/meta.dart';

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
    required UpiMethodChannel upiMethodChannel,
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType:
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType:
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      return await discovery!.discover(
        upiMethodChannel: upiMethodChannel,
        applicationStatusMap: applicationStatusMap,
        paymentType: paymentType,
        statusType: statusType,
      );
    }
    throw UnsupportedError('Discovery is available only on Android and iOS');
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
    required UpiMethodChannel upiMethodChannel,
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType:
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType:
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    final appsList = await upiMethodChannel.getInstalledUpiApps();
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
    required UpiMethodChannel upiMethodChannel,
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType:
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType:
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
        final bool? result = await upiMethodChannel.canLaunch(scheme);
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
    required UpiMethodChannel upiMethodChannel,
    required Map<UpiApplication, UpiApplicationStatus> applicationStatusMap,
    UpiApplicationDiscoveryAppPaymentType paymentType:
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType:
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

/// Represents the type of payments in the apps that user wants to access.
///
/// Passed as [paymentType] parameter of [UpiPay.getInstalledUpiApplications]
/// API.
enum UpiApplicationDiscoveryAppPaymentType {
  /// Individual-to-individual payment type. If this type is passed, then
  /// the package finds packages for which such payment works. Currently, it's
  /// the only type accepted.
  nonMerchant,

  /// Merchant payment type. Currently not accepted. Will represent merchant
  /// payment type once they are supported.
  merchant,

  /// Both individual-to-individual and merchant payment types. Not accepted
  /// currently.
  both,
}

/// Represents the UPI payment working status of apps that user wants to access.
///
/// Passed as [statusType] parameter of [UpiPay.getInstalledUpiApplications]
/// API.
enum UpiApplicationDiscoveryAppStatusType {
  /// Indicates that user wants UPI apps with any working status (they must be
  /// discoverable, though)
  all,

  /// Indicates that user wants UPI apps that complete the UPI payment and may
  /// or may not involve the "unverified source" warning. Currently, only
  /// individual-to-individual payments are implemented, and this status type
  /// is relevant for them only as some apps give this warning in the payment
  /// process and take confirmation from user before proceeding for this type
  /// of payments. For merchant payments, this type may become irrelevant.
  workingWithWarnings,

  /// Indicates that user wants UPI apps that complete the UPI payment without
  /// the "unverified source" warning
  working,
}
