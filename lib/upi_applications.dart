import 'package:device_apps/device_apps.dart';

enum _UPIApplication {
  googlePay,
  phonePe,
  payTM,
  sbiPay,
  bhim,
  miPay,
  amazonPay,
  trueCallerUPI,
  myAirtelUPI
}

class UPIApplication {
  final _UPIApplication _inner;

  UPIApplication._(this._inner);

  static final googlePay = UPIApplication._(_UPIApplication.googlePay);
  static final phonePe = UPIApplication._(_UPIApplication.phonePe);
  static final payTM = UPIApplication._(_UPIApplication.payTM);
  static final sbiPay = UPIApplication._(_UPIApplication.sbiPay);
  static final bhim = UPIApplication._(_UPIApplication.bhim);
  static final miPay = UPIApplication._(_UPIApplication.miPay);
  static final amazonPay = UPIApplication._(_UPIApplication.amazonPay);
  static final trueCallerUPI = UPIApplication._(_UPIApplication.trueCallerUPI);
  static final myAirtelUPI = UPIApplication._(_UPIApplication.myAirtelUPI);

  String toString() {
    switch (_inner) {
      case _UPIApplication.googlePay:
        return "com.google.android.apps.nbu.paisa.user";
      case _UPIApplication.phonePe:
        return 'com.phonepe.app';
      case _UPIApplication.payTM:
        return 'net.one97.paytm';
      case _UPIApplication.sbiPay:
        return 'com.sbi.upi';
      case _UPIApplication.bhim:
        return 'in.org.npci.upiapp';
      case _UPIApplication.miPay:
        return 'com.mipay.wallet.in';
      case _UPIApplication.amazonPay:
        return 'in.amazon.mShop.android.shopping';
      case _UPIApplication.trueCallerUPI:
        return 'com.truecaller';
      case _UPIApplication.myAirtelUPI:
        return 'com.myairtelapp';
      default:
        throw UnsupportedError('Invalid / Unsupported UPI Application');
    }
  }
}

class UPIApplications {
  static final List<String> _validUPIPackageNames = [
    UPIApplication.googlePay,
    UPIApplication.phonePe,
    UPIApplication.payTM,
    UPIApplication.sbiPay,
    UPIApplication.bhim,
    UPIApplication.miPay,
    UPIApplication.amazonPay,
    UPIApplication.trueCallerUPI,
    UPIApplication.myAirtelUPI
  ].map((app) => app.toString()).toList();

  static Future<List<ApplicationWithIcon>>
      getAllInstalledUPIApplications() async {
    final allInstalledApps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: false);

    return List.from(allInstalledApps.where((app) =>
        UPIApplications._validUPIPackageNames.contains(app.packageName)));
  }

  static Future<bool> checkIfUPIApplicationIsInstalled(
      UPIApplication app) async {
    return await DeviceApps.isAppInstalled(app.toString());
  }
}
