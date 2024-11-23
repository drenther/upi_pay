import 'package:decimal/decimal.dart';
import 'package:upi_pay/types/applications.dart';
import 'package:upi_pay/types/exceptions.dart';

class TransactionDetails {
  static const String _currency = 'INR';
  static const int _maxAmount = 100000;

  final UpiApplication upiApplication;
  final String payeeAddress;
  final String payeeName;
  final String transactionRef;
  final String currency;
  final Decimal amount;
  final String? url;
  final String merchantCode;
  final String? transactionNote;

  TransactionDetails({
    required this.upiApplication,
    required this.payeeAddress,
    required this.payeeName,
    required this.transactionRef,
    this.currency = TransactionDetails._currency,
    required String amount,
    this.url,
    this.merchantCode = '',
    this.transactionNote = 'UPI Transaction',
  }) : amount = Decimal.parse(amount) {
    if (!_checkIfUpiAddressIsValid(payeeAddress)) {
      throw InvalidUpiAddressException();
    }
    final Decimal am = Decimal.parse(amount);
    if (am.scale > 2) {
      throw InvalidAmountException(
          'Amount must not have more than 2 digits after decimal point');
    }
    if (am <= Decimal.zero) {
      throw InvalidAmountException('Amount must be greater than 1');
    }
    if (am > Decimal.fromInt(_maxAmount)) {
      throw InvalidAmountException(
          'Amount must be less then 1,00,000 since that is the upper limit '
          'per UPI transaction');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'app': upiApplication.toString(),
      'pa': payeeAddress,
      'pn': payeeName,
      'tr': transactionRef,
      'cu': currency,
      'am': amount.toString(),
      'url': url,
      'mc': merchantCode,
      'tn': transactionNote,
    };
  }

  String toString() {
    String uri = 'upi://pay?pa=$payeeAddress'
        '&pn=${Uri.encodeComponent(payeeName)}'
        '&tr=$transactionRef'
        '&tn=${Uri.encodeComponent(transactionNote!)}'
        '&am=${amount.toString()}'
        '&cu=$currency';
    if (url != null && url!.isNotEmpty) {
      uri += '&url=${Uri.encodeComponent(url!)}';
    }
    if (merchantCode.isNotEmpty) {
      uri += '&mc=${Uri.encodeComponent(merchantCode)}';
    }
    return uri;
  }
}

bool _checkIfUpiAddressIsValid(String upiAddress) {
  return upiAddress.split('@').length == 2;
}
