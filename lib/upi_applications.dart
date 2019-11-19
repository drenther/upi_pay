import 'package:device_apps/device_apps.dart';

enum UPIApplication {
  GooglePay,
  PhonePe,
  PayTM,
  SBIPay,
  BHIM,
  MiPay,
  AmazonPay,
  TrueCallerUPI,
  MyAirtelUPI
}

String getUPIApplicationPackageName(UPIApplication app) {
  switch (app) {
    case UPIApplication.GooglePay:
      return "com.google.android.apps.nbu.paisa.user";
    case UPIApplication.PhonePe:
      return 'com.phonepe.app';
    case UPIApplication.PayTM:
      return 'net.one97.paytm';
    case UPIApplication.SBIPay:
      return 'com.sbi.upi';
    case UPIApplication.BHIM:
      return 'in.org.npci.upiapp';
    case UPIApplication.MiPay:
      return 'com.mipay.wallet.in';
    case UPIApplication.AmazonPay:
      return 'in.amazon.mShop.android.shopping';
    case UPIApplication.TrueCallerUPI:
      return 'com.truecaller';
    case UPIApplication.MyAirtelUPI:
      return 'com.myairtelapp';
    default:
      throw UnsupportedError('Invalid / Unsupported UPI Application');
  }
}

class UPIApplications {
  static final List<String> _validUPIPackageNames = [
    UPIApplication.GooglePay,
    UPIApplication.PhonePe,
    UPIApplication.PayTM,
    UPIApplication.SBIPay,
    UPIApplication.BHIM,
    UPIApplication.MiPay,
    UPIApplication.AmazonPay,
    UPIApplication.TrueCallerUPI,
    UPIApplication.MyAirtelUPI
  ].map((app) => getUPIApplicationPackageName(app));

  static Future<List<Application>> getAllInstalledUPIApplications() async {
    final allInstalledApps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: false);

    return List.from(allInstalledApps.where((app) =>
        UPIApplications._validUPIPackageNames.contains(app.packageName)));
  }

  static Future<bool> checkIfUPIApplicationIsInstalled(
      UPIApplication app) async {
    return await DeviceApps.isAppInstalled(getUPIApplicationPackageName(app));
  }
}
