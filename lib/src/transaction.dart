import 'package:universal_io/io.dart' as io;
import 'package:upi_pay/src/platform_interface.dart';
import 'package:upi_pay/types/response.dart';
import 'package:upi_pay/types/transaction_details.dart';

class UpiTransactionHelper implements _PlatformTransactionHelperBase {
  final helper = io.Platform.isAndroid
      ? AndroidTransactionHelper()
      : io.Platform.isIOS
          ? IosTransactionHelper()
          : null;
  static final _singleton = UpiTransactionHelper._inner();
  factory UpiTransactionHelper() {
    return _singleton;
  }
  UpiTransactionHelper._inner();

  @override
  Future<UpiTransactionResponse> transact(
      TransactionDetails transactionDetails) async {
    if (!(io.Platform.isAndroid || io.Platform.isIOS)) {
      throw UnsupportedError(
          'UPI transaction is available only on Android and iOS');
    }
    return helper!.transact(transactionDetails);
  }
}

class AndroidTransactionHelper implements _PlatformTransactionHelperBase {
  static final _singleton = AndroidTransactionHelper._inner();
  factory AndroidTransactionHelper() {
    return _singleton;
  }
  AndroidTransactionHelper._inner();

  @override
  Future<UpiTransactionResponse> transact(
      TransactionDetails transactionDetails) async {
    String? responseString =
        await UpiPayPlatform.instance.initiateTransaction(transactionDetails);
    return UpiTransactionResponse.android(
        responseString == null ? "" : responseString);
  }
}

class IosTransactionHelper implements _PlatformTransactionHelperBase {
  static final _singleton = IosTransactionHelper._inner();
  factory IosTransactionHelper() {
    return _singleton;
  }
  IosTransactionHelper._inner();

  @override
  Future<UpiTransactionResponse> transact(
      TransactionDetails transactionDetails) async {
    try {
      final bool? result =
          await UpiPayPlatform.instance.launch(transactionDetails);
      return UpiTransactionResponse.ios(result != null ? result : false);
    } catch (error, stack) {
      print('iOS UPI app launch failure: $error');
      print('iOS UPI app launch failure stack: $stack');
      return UpiTransactionResponse.iosError(error);
    }
  }
}

abstract class _PlatformTransactionHelperBase {
  Future<UpiTransactionResponse> transact(
      TransactionDetails transactionDetails);
}
