enum _UpiApplication {
  googlePay,
  phonePe,
  payTM,
  sbiPay,
  iMobileICICI,
  bhim,
  miPay,
  amazonPay,
  trueCallerUpi,
  myAirtelUpi
}

class UpiApplication {
  final _UpiApplication _inner;

  UpiApplication._(this._inner);

  static final googlePay = UpiApplication._(_UpiApplication.googlePay);
  static final phonePe = UpiApplication._(_UpiApplication.phonePe);
  static final payTM = UpiApplication._(_UpiApplication.payTM);
  static final sbiPay = UpiApplication._(_UpiApplication.sbiPay);
  static final iMobileICICI = UpiApplication._(UpiApplication.iMobileICICI);
  static final bhim = UpiApplication._(_UpiApplication.bhim);
  static final miPay = UpiApplication._(_UpiApplication.miPay);
  static final amazonPay = UpiApplication._(_UpiApplication.amazonPay);
  static final trueCallerUpi = UpiApplication._(_UpiApplication.trueCallerUpi);
  static final myAirtelUpi = UpiApplication._(_UpiApplication.myAirtelUpi);

  String toString() {
    switch (_inner) {
      case _UpiApplication.googlePay:
        return "com.google.android.apps.nbu.paisa.user";
      case _UpiApplication.phonePe:
        return 'com.phonepe.app';
      case _UpiApplication.payTM:
        return 'net.one97.paytm';
      case _UpiApplication.sbiPay:
        return 'com.sbi.upi';
      case _UpiApplication.iMobileICICI:
        return 'com.csam.icici.bank.imobile';
      case _UpiApplication.bhim:
        return 'in.org.npci.upiapp';
      case _UpiApplication.miPay:
        return 'com.mipay.wallet.in';
      case _UpiApplication.amazonPay:
        return 'in.amazon.mShop.android.shopping';
      case _UpiApplication.trueCallerUpi:
        return 'com.truecaller';
      case _UpiApplication.myAirtelUpi:
        return 'com.myairtelapp';
      default:
        throw UnsupportedError('Invalid / Unsupported UPI Application');
    }
  }

  String getAppName() {
    switch (_inner) {
      case _UpiApplication.googlePay:
        return "Google Pay";
      case _UpiApplication.phonePe:
        return 'PhonePe';
      case _UpiApplication.payTM:
        return 'Paytm';
      case _UpiApplication.sbiPay:
        return 'SBI Pay';
      case _UpiApplication.bhim:
        return 'BHIM';
      case _UpiApplication.miPay:
        return 'MiPay';
      case _UpiApplication.amazonPay:
        return 'Amazon Pay';
      case _UpiApplication.trueCallerUpi:
        return 'Truecaller';
      case _UpiApplication.myAirtelUpi:
        return 'MyAirtel';
      default:
        throw UnsupportedError('Invalid / Unsupported UPI Application');
    }
  }
}
