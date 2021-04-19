import 'dart:io';

/// Represents status of executing a UPI transaction by launching a UPI app.
enum UpiTransactionStatus {
  /// UPI transaction submitted and is yet to complete (Android-only)
  /// See `Status` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  submitted,
  /// UPI transaction is successful (Android-only)
  /// See `Status` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  success,
  /// UPI transaction failed (Android-only)
  /// See `Status` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  failure,
  /// UPI payment app launched with transaction parameters (iOS-only)
  launched,
  /// UPI payment app launch failed (iOS-only)
  failedToLaunch,
}

/// Structured data representing response of a UPI transaction request.
class UpiTransactionResponse {
  /// See `txnId` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  /// "Response Parameters" section (Android-only)
  String _txnId;
  /// See `responseCode` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf) (Android-only)
  String _responseCode;
  /// See `ApprovalRefNo` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf) (Android-only)
  String _approvalRefNo;
  /// Status of transaction on Android / iOS
  UpiTransactionStatus _status;
  /// See `txnRef` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf) (Android-only)
  String _txnRef;
  /// Response string in the format specified in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf) (Android-only)
  String _rawResponse;
  /// UPI app launch exception (iOS-only)
  String _launchError;

  /// Android platform constructor.
  ///
  /// Parses the response as per the [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  /// to populate Android-specific attributes.
  UpiTransactionResponse.android(String responseString) {
    this._rawResponse = responseString;
    // Consider the response to be failure if success or submitted is not explicitly returned.
    this._status = UpiTransactionStatus.failure;
    List<String> fragments = responseString.split('&');
    fragments.forEach((fragment) {
      List<String> keyValuePair = fragment.split('=');
      String normalizedKey = keyValuePair.first.toLowerCase();
      String value = keyValuePair.last;
      switch (normalizedKey) {
        case 'txnid':
          this._txnId = value;
          break;
        case 'responsecode':
          this._responseCode = value;
          break;
        case 'approvalrefno':
          this._approvalRefNo = value;
          break;
        case 'status':
          if (value.toLowerCase().contains('success')) {
            this._status = UpiTransactionStatus.success;
          } else if (value.toLowerCase().contains('fail')) {
            this._status = UpiTransactionStatus.failure;
          } else if (value.toLowerCase().contains('submitted')) {
            this._status = UpiTransactionStatus.submitted;
          } else if (value.toLowerCase() == 's') {
            this._status =
                UpiTransactionStatus.success; // YuvaPay returns status=S
          } else {
            throw UnsupportedError('Unsupported UPI Transaction Status');
          }
          break;
        case 'txnref':
          this._txnRef = value;
      }
    });
  }

  /// iOS platform constructor.
  ///
  /// Populates [_status] as per the [result].
  UpiTransactionResponse.ios(bool result) {
    _status = result
        ? UpiTransactionStatus.launched
        : UpiTransactionStatus.failedToLaunch;
  }

  /// iOS platform app launch exception case constructor.
  ///
  /// Populates [_status] and [_launchError].
  UpiTransactionResponse.iosError(error) {
    _status = UpiTransactionStatus.failedToLaunch;
    _launchError = error.toString();
  }

  String toString() {
    return 'UpiTransactionResponse { txnId: $_txnId, responseCode: '
        '$_responseCode, approvalRefNo: $_approvalRefNo, status: $_status, '
        'txnRef: $_txnRef, rawResponse: $_rawResponse }';
  }

  /// Getter for [_txnId]. Leads to [UnsupportedError] on iOs.
  String get txnId {
    if (Platform.isAndroid) {
      return _txnId;
    }
    throw UnsupportedError('The attribute txnId is not available on iOS');
  }

  /// Getter for [_responseCode]. Leads to [UnsupportedError] on iOs.
  String get responseCode {
    if (Platform.isAndroid) {
      return _responseCode;
    }
    throw UnsupportedError(
        'The attribute responseCode is not available on iOS');
  }

  /// Getter for [_approvalRefNo]. Leads to [UnsupportedError] on iOs.
  String get approvalRefNo {
    if (Platform.isAndroid) {
      return _approvalRefNo;
    }
    throw UnsupportedError(
        'The attribute approvalRefNo is not available on iOS');
  }

  /// Getter for [_status].
  UpiTransactionStatus get status => _status;

  /// Getter for [_txnRef]. Leads to [UnsupportedError] on iOs.
  String get txnRef {
    if (Platform.isAndroid) {
      return _txnRef;
    }
    throw UnsupportedError('The attribute txnRef is not available on iOS');
  }

  /// Getter for [_rawResponse]. Leads to [UnsupportedError] on iOs.
  String get rawResponse {
    if (Platform.isAndroid) {
      return _rawResponse;
    }
    throw UnsupportedError('The attribute rawResponse is not available on iOS');
  }

  /// Getter for [_launchError]. Leads to [UnsupportedError] on Android.
  String get launchError {
    if (Platform.isIOS) {
      return _launchError;
    }
    throw UnsupportedError(
        'The attribute launchError is not available on Android');
  }
}
