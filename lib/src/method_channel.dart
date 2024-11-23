import 'package:universal_io/io.dart' as io;
import 'package:flutter/services.dart';
import 'package:upi_pay/types/transaction_details.dart';
import 'package:flutter/foundation.dart';

import 'platform_interface.dart';

/// An implementation of [UpiPayPlatform] that uses method channels.
class MethodChannelUpiPay extends UpiPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('upi_pay');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<String?> initiateTransaction(
      TransactionDetails transactionDetails) async {
    if (!io.Platform.isAndroid) {
      throw UnsupportedError(
          'The `initiateTransaction` call is supported only on Android');
    }
    return methodChannel.invokeMethod<String>(
        'initiateTransaction', transactionDetails.toJson());
  }

  Future<bool?> launch(TransactionDetails transactionDetails) async {
    if (!io.Platform.isIOS) {
      throw UnsupportedError('The `launch` call is supported only on iOS');
    }
    return methodChannel
        .invokeMethod<bool>('launch', {'uri': transactionDetails.toString()});
  }

  Future<List<Map<dynamic, dynamic>>?> getInstalledUpiApps() async {
    if (!io.Platform.isAndroid) {
      throw UnsupportedError('The `getInstalledUpiApps` call is supported only '
          'on Android');
    }
    return methodChannel
        .invokeListMethod<Map<dynamic, dynamic>>('getInstalledUpiApps');
  }

  Future<bool?> canLaunch(String scheme) async {
    if (!io.Platform.isIOS) {
      throw UnsupportedError('The `canLaunch` call is supported only on iOS');
    }
    return methodChannel
        .invokeMethod<bool>('canLaunch', {'uri': scheme + "://"});
  }
}
