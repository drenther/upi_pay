import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_applications.dart';

class InvalidUPIAddressException implements Exception {
  String message = 'Invalid UPI Address';

  InvalidUPIAddressException([this.message]);

  @override
  String toString() => this.message;
}

class InvalidAmountException implements Exception {
  String message;

  InvalidAmountException(this.message);

  @override
  String toString() => this.message;
}

class UpiPay {
  static const MethodChannel _channel = const MethodChannel('upi_pay');

  /// needs to be updated in case any new handle names are added
  /// which doesn't happen frequently
  ///
  /// Reference - https://www.npci.org.in/upi-PSP%263rdpartyApps
  static const List<String> validUPIHandles = [
    "@axisgo",
    "@pingpay",
    "@axisbank",
    "@apl",
    "@axisb",
    "@abfspay",
    "@fbl",
    "@hdfcbankjd",
    "@ikwik",
    "@idfcbank",
    "@kmbl",
    "@indus",
    "@yesbank",
    "@ybl",
    "@okaxis",
    "@icici",
    "@icicibank",
    "@myicici"
  ];

  // UPI current transaction upper limit
  static const int _maxAmount = 100000;

  // UPI currently only support INR
  static const String _currency = 'INR';

  static bool _checkIfUPIAddressIsValid(String upiAddress) {
    return UpiPay.validUPIHandles
        .any((handler) => upiAddress.endsWith(handler));
  }

  /// Start a UPI Transaction
  ///
  /// Required parameters are as follows -
  /// For the [app] (app in UPI Specification) argument a value from the [UPIApplication] enum must be provided
  ///
  /// For the [receiverUPIAddress] (pa in UPI Specification) argument the UPI address of the receiver must be provided
  /// it must end with a valid handle name otherwise it will throw [InvalidUPIAddressException]
  ///
  /// For the [receiverName] (pn in UPI Specification) argument the name of the receiver must be provided
  ///
  /// For the [transactionRef] (tr in UPI Specification) argument a string value must be provided
  /// which must be unique for each request from your business must
  ///
  /// For the [amount] (am in UPI Specification) argument expects a string value of between 0 to 1,00,000
  /// The amount must not have more than 2 decimal digit precision
  /// Also, beware that some UPI Apps have lower per transaction upper limit
  ///
  /// Optional Arguments include
  /// [merchantCode] (mc in UPI Specification) - can be used to denote business category code
  /// [transactionNote] (tn in UPI  Specification) - can be used to provide a short description of the transaction
  ///
  /// UPI Linking Specification - https://www.npci.org.in/sites/all/themes/npcl/images/PDF/UPI_Linking_Specs_ver_1.5.1.pdf
  static Future<String> initiateTransaction(
      {@required UPIApplication app,
      @required String receiverUPIAddress,
      @required String receiverName,
      @required String transactionRef,
      @required String amount,
      String transactionNote,
      String merchantCode}) async {
    // check receiver address validity
    if (UpiPay._checkIfUPIAddressIsValid(receiverUPIAddress)) {
      throw InvalidUPIAddressException();
    }

    // check amount validity
    final Decimal am = Decimal.parse(amount);
    if (am.precision > 2) {
      throw InvalidAmountException(
          'Amount must not have more than 2 decimal precision');
    }
    if (am <= Decimal.zero) {
      throw InvalidAmountException('Amount must be greater than 1');
    }
    if (am > Decimal.fromInt(UpiPay._maxAmount)) {
      throw InvalidAmountException(
          'Amount must be less then 1,00,000 since that is the upper limit per UPI transaction');
    }

    final responseString = await _channel.invokeMethod('initiateTransaction', {
      'app': app.toString(),
      'pa': receiverUPIAddress,
      'pn': receiverName,
      'tr': transactionRef,
      'cu': UpiPay._currency,
      'am': amount.toString(),
      'mc': merchantCode,
      'tn': transactionNote,
    });

    return responseString;
  }

  // template method
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
