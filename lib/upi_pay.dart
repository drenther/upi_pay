import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_applications.dart';

export 'package:upi_pay/upi_applications.dart';

class _UpiException implements Exception {
  String message;

  _UpiException(this.message);

  @override
  String toString() => this.message;
}

class InvalidUpiAddressException extends _UpiException {
  InvalidUpiAddressException([String msg])
      : super(msg ?? 'Invalid UPI Address');
}

class InvalidAmountException extends _UpiException {
  InvalidAmountException(String msg) : super(msg);
}

class UpiAppIsNotInstalledException extends _UpiException {
  UpiAppIsNotInstalledException([String msg])
      : super(msg ?? 'UPI App is not installed');
}

enum UpiTransactionStatus { submitted, success, failure }

class UpiTransactionResponse {
  String txnId;
  String responseCode;
  String approvalRefNo;
  UpiTransactionStatus status;
  String txnRef;
  String rawResponse;

  UpiTransactionResponse(String responseString) {
    this.rawResponse = responseString;

    List<String> fragments = responseString.split('&');

    fragments.forEach((fragment) {
      List<String> keyValuePair = fragment.split('=');
      String normalizedKey = keyValuePair.first.toLowerCase();
      String value = keyValuePair.last;

      switch (normalizedKey) {
        case 'txnid':
          this.txnId = value;
          break;
        case 'responsecode':
          this.responseCode = value;
          break;
        case 'approvalrefno':
          this.approvalRefNo = value;
          break;
        case 'status':
          if (value.toLowerCase().contains('success')) {
            this.status = UpiTransactionStatus.success;
          } else if (value.toLowerCase().contains('fail')) {
            this.status = UpiTransactionStatus.failure;
          } else if (value.toLowerCase().contains('submitted')) {
            this.status = UpiTransactionStatus.submitted;
          } else {
            throw UnsupportedError('Unsupported UPI Transaction Status');
          }
          break;
        case 'txnref':
          this.txnRef = value;
      }
    });
  }
}

class UpiPay {
  static const MethodChannel _channel = const MethodChannel('upi_pay');

  /// needs to be updated in case any new handle names are added
  /// which doesn't happen frequently
  ///
  /// Reference - https://www.npci.org.in/upi-PSP%263rdpartyApps
  static const List<String> validUpiHandles = [
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

  static bool checkIfUpiAddressIsValid(String upiAddress) {
    return UpiPay.validUpiHandles
        .any((handler) => upiAddress.endsWith(handler));
  }

  /// Start a UPI Transaction
  ///
  /// Required parameters are as follows -
  /// For the [app] (app in UPI Specification) argument a value from the [UpiApplication] enum must be provided
  ///
  /// For the [receiverUpiAddress] (pa in UPI Specification) argument the UPI address of the receiver must be provided
  /// it must end with a valid handle name otherwise it will throw [InvalidUpiAddressException]
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
  static Future<UpiTransactionResponse> initiateTransaction(
      {@required UpiApplication app,
      @required String receiverUpiAddress,
      @required String receiverName,
      @required String transactionRef,
      @required String amount,
      String transactionNote,
      String merchantCode}) async {
    // check receiver address validity
    if (UpiPay.checkIfUpiAddressIsValid(receiverUpiAddress)) {
      throw InvalidUpiAddressException();
    }

    // check if app is installed
    if (await UpiApplications.checkIfUpiApplicationIsInstalled(app)) {
      throw UpiAppIsNotInstalledException();
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

    String responseString = await _channel.invokeMethod('initiateTransaction', {
      'app': app.toString(),
      'pa': receiverUpiAddress,
      'pn': receiverName,
      'tr': transactionRef,
      'cu': UpiPay._currency,
      'am': amount.toString(),
      'mc': merchantCode,
      'tn': transactionNote,
    });

    return UpiTransactionResponse(responseString);
  }
}
