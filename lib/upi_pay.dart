import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_applications.dart';

class InvalidUPIAddressException implements Exception {
  String message = 'Invalid UPI Address';

  InvalidUPIAddressException([this.message]);

  @override
  String toString() => this.message;
}

class UpiPay {
  static const MethodChannel _channel = const MethodChannel('upi_pay');

  // needs to be updated in case any new handle names are added
  // which doesn't happen frequently
  // Reference - https://www.npci.org.in/upi-PSP%263rdpartyApps
  static const List<String> _validUPIHandles = [
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

// UPI currently only support INR
  static final String _currency = 'INR';

  static bool _checkIfUPIAddressIsValid(String upiAddress) {
    return UpiPay._validUPIHandles
        .any((handler) => upiAddress.endsWith(handler));
  }

  /// Start a UPI Transaction
  ///
  /// Required parameters are as follows -
  /// For the [app] argument a value from the [UPIApplication] enum must be provided
  ///
  /// For the [receiverUPIAddress] (a.k.a [pa]) argument the UPI address of the receiver must be provided
  /// it must end with a valid handle name otherwise it will throw [InvalidUPIAddressException]
  ///
  /// For the [receiverName] (a.k.a [pn]) argument the name of the receiver must be provided
  ///
  /// For the [transactionRef] (a.k.a [tr]) argument a string value must be provided
  /// which must be unique for each request from your business must
  ///
  /// For the []
  static Future<String> initiateTransaction(
      {@required UPIApplication app,
      @required String receiverUPIAddress,
      @required String receiverName,
      String merchantCode}) async {
    if (UpiPay._checkIfUPIAddressIsValid(receiverUPIAddress)) {
      throw InvalidUPIAddressException();
    }

    final responseString = await _channel.invokeMethod('initiateTransaction', {
      'app': getUPIApplicationPackageName(app),
      'pa': receiverUPIAddress,
      'pn': receiverName,
      'mc': merchantCode,
      'cu': UpiPay._currency
    });

    return responseString;
  }

  // template method
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
