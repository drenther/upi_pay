import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:upi_pay/types/transaction_details.dart';

import 'method_channel.dart';

abstract class UpiPayPlatform extends PlatformInterface {
  /// Constructs a UpiPayPlatform.
  UpiPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static UpiPayPlatform _instance = MethodChannelUpiPay();

  /// The default instance of [UpiPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelUpiPay].
  static UpiPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UpiPayPlatform] when
  /// they register themselves.
  static set instance(UpiPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> initiateTransaction(
      TransactionDetails transactionDetails) async {
    throw UnimplementedError('initiateTransaction() has not been implemented.');
  }

  Future<bool?> launch(TransactionDetails transactionDetails) async {
    throw UnimplementedError('launch() has not been implemented.');
  }

  Future<List<Map<dynamic, dynamic>>?> getInstalledUpiApps() async {
    throw UnimplementedError('getInstalledUpiApps() has not been implemented.');
  }

  Future<bool?> canLaunch(String scheme) async {
    throw UnimplementedError('canLaunch() has not been implemented.');
  }
}
