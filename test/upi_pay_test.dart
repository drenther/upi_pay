import 'package:flutter_test/flutter_test.dart';
import 'package:upi_pay/types/transaction_details.dart';
import 'package:upi_pay/upi_pay.dart';
import 'package:upi_pay/src/platform_interface.dart';
import 'package:upi_pay/src/method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUpiPayPlatform
    with MockPlatformInterfaceMixin
    implements UpiPayPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> canLaunch(String scheme) {
    // TODO: implement canLaunch
    throw UnimplementedError();
  }

  @override
  Future<List<Map>?> getInstalledUpiApps() {
    // TODO: implement getInstalledUpiApps
    throw UnimplementedError();
  }

  @override
  Future<String?> initiateTransaction(TransactionDetails transactionDetails) {
    // TODO: implement initiateTransaction
    throw UnimplementedError();
  }

  @override
  Future<bool?> launch(TransactionDetails transactionDetails) {
    // TODO: implement launch
    throw UnimplementedError();
  }
}

void main() {
  final UpiPayPlatform initialPlatform = UpiPayPlatform.instance;

  test('$MethodChannelUpiPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUpiPay>());
  });

  test('getPlatformVersion', () async {
    UpiPay upiPayPlugin = UpiPay();
    MockUpiPayPlatform fakePlatform = MockUpiPayPlatform();
    UpiPayPlatform.instance = fakePlatform;

    expect(await upiPayPlugin.getPlatformVersion(), '42');
  });
}
