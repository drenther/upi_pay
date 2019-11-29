import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

    // Consider the response to be failure if success or submitted is not explicitly returned.
    this.status = UpiTransactionStatus.failure;

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

  String toString() {
    return 'UpiTransactionResponse { txnId: $txnId, responseCode: $responseCode, approvalRefNo: $approvalRefNo, status: $status, txnRef: $txnRef, rawResponse: $rawResponse }';
  }
}

final List<UpiApplication> _validUpiPackageNames = [
  UpiApplication.googlePay,
  UpiApplication.phonePe,
  UpiApplication.payTM,
  UpiApplication.sbiPay,
  UpiApplication.bhim,
  UpiApplication.miPay,
  UpiApplication.amazonPay,
  UpiApplication.trueCallerUpi,
  UpiApplication.myAirtelUpi
];

class UpiPay {
  static const MethodChannel _channel = const MethodChannel('upi_pay');

  // UPI current transaction upper limit
  static const int _maxAmount = 100000;

  // UPI currently only support INR
  static const String _currency = 'INR';

  static bool checkIfUpiAddressIsValid(String upiAddress) {
    return upiAddress.split('@').length == 2;
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
  /// [url] (url in UPI Specification) - can be used to pass a shareable link related to the transaction like an invoice copy, etc.
  /// [merchantCode] (mc in UPI Specification) - can be used to denote business category code
  /// [transactionNote] (tn in UPI  Specification) - can be used to provide a short description of the transaction
  ///
  /// UPI Linking Specification - https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf
  static Future<UpiTransactionResponse> initiateTransaction({
    @required UpiApplication app,
    @required String receiverUpiAddress,
    @required String receiverName,
    @required String transactionRef,
    @required String amount,
    String url,
    String transactionNote,
    String merchantCode,
  }) async {
    assert(app != null);
    assert(receiverUpiAddress != null);
    assert(receiverName != null);
    assert(transactionRef != null);
    assert(amount != null);

    // check receiver address validity
    if (!UpiPay.checkIfUpiAddressIsValid(receiverUpiAddress)) {
      throw InvalidUpiAddressException();
    }

    // check amount validity
    final Decimal am = Decimal.parse(amount);
    if (am.scale > 2) {
      throw InvalidAmountException(
          'Amount must not have more than 2 digits after decimal point');
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
      'am': am.toString(),
      'url': url,
      'mc': merchantCode,
      'tn': transactionNote,
    });

    return UpiTransactionResponse(responseString);
  }

  static Future<List<ApplicationMeta>> getInstalledUpiApplications() async {
    final appsList =
        await _channel.invokeListMethod<Map>('getInstalledUpiApps');

    final upiApps = appsList
        .map((app) {
          final packageName = _castToString(app['packageName']);
          final upiApp = _validUpiPackageNames.firstWhere(
            (it) => packageName == it.toString(),
            orElse: () => null,
          );

          if (upiApp == null) {
            return null;
          }

          final icon = _castToString(app['icon']);
          final priority = _castToInt(app['priority']);
          final preferredOrder = _castToInt(app['preferredOrder']);

          return ApplicationMeta._(
            upiApp,
            packageName,
            base64.decode(icon),
            priority,
            preferredOrder,
          );
        })
        .where((it) => it != null)
        .toList();

    return upiApps;
  }
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

class ApplicationMeta {
  ApplicationMeta._(
    this._upiApplication,
    this._packageName,
    this._icon,
    this._priority,
    this._preferredOrder,
  );

  UpiApplication _upiApplication;
  UpiApplication get upiApplication => _upiApplication;

  String _packageName;
  String get packageName => _packageName;

  Uint8List _icon;
  Uint8List get icon => _icon;

  int _priority;
  int get priority => _priority;

  int _preferredOrder;
  int get preferredOrder => _preferredOrder;
}
