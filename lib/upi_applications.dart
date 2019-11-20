import 'package:device_apps/device_apps.dart';

enum _UpiApplication {
  googlePay,
  phonePe,
  payTM,
  sbiPay,
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
}

class UpiApplications {
  static final List<String> _validUpiPackageNames = [
    UpiApplication.googlePay,
    UpiApplication.phonePe,
    UpiApplication.payTM,
    UpiApplication.sbiPay,
    UpiApplication.bhim,
    UpiApplication.miPay,
    UpiApplication.amazonPay,
    UpiApplication.trueCallerUpi,
    UpiApplication.myAirtelUpi
  ].map((app) => app.toString()).toList();

  static Future<List<ApplicationWithIcon>>
      getAllInstalledUpiApplications() async {
    var allInstalledApps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: false);

    var iterable = allInstalledApps.where((app) =>
        UpiApplications._validUpiPackageNames.contains(app.packageName));

    iterable = iterable.map((app) {
      if (app is ApplicationWithIcon) {
        return app;
      }
      return null;
    }).where((app) => app != null);

    return List.from(iterable);
  }

  static Future<bool> checkIfUpiApplicationIsInstalled(
      UpiApplication app) async {
    return await DeviceApps.isAppInstalled(app.toString());
  }
}
