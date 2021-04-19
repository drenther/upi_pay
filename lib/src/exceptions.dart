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
