import 'package:universal_io/io.dart' as io;
import 'package:flutter/cupertino.dart';

/// Represents a UPI payment application.
///
/// Stores unique identifiers for a UPI payment application across Android and
/// iOS. On iOS, the information required to discover the app is also stored.
class UpiApplication {
  /// Value of `package` attribute in `manifest` tag in `AndroidManifest.xml`
  /// of Android version of a UPI app. Serves as the identifier on Android.
  final String androidPackageName;

  /// Value of `CFBundleIdentifier` property in `Info.plist` of the iOS version
  /// of a UPI app. Serves as the identifier on iOS.
  final String iosBundleId;

  /// Friendly and typically a shorter version of a UPI app's name.
  final String appName;

  /// As per the [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf),
  /// each iOS UPI app that can be invoked directly for UPI payment must
  /// implement the custom scheme `upi`. For the purpose of discovering an iOS
  /// UPI app without ambiguity, we need any other unique custom scheme that the
  /// app implements. Any such unique custom scheme, if available, is stored in
  /// this attribute to be used for discovering this app.
  final String discoveryCustomScheme;

  UpiApplication({
    @required this.androidPackageName,
    this.iosBundleId,
    @required this.appName,
    this.discoveryCustomScheme,
  }) {
    if (io.Platform.isAndroid) {
      lookUpMap[this.androidPackageName] = this;
    } else {
      lookUpMap[this.iosBundleId] = this;
    }
  }

  /// Google Pay
  static final googlePay = UpiApplication(
    androidPackageName: 'com.google.android.apps.nbu.paisa.user',
    iosBundleId: 'com.google.paisa',
    appName: 'Google Pay',
    discoveryCustomScheme: 'gpay',
  );
  /// PhonePe
  static final phonePe = UpiApplication(
    androidPackageName: 'com.phonepe.app',
    iosBundleId: 'com.phonepe.PhonePeApp',
    appName: 'PhonePe',
    discoveryCustomScheme: 'phonepe',
  );
  /// Paytm
  static final paytm = UpiApplication(
    androidPackageName: 'net.one97.paytm',
    iosBundleId: 'com.one97.paytm',
    appName: 'Paytm',
    discoveryCustomScheme: 'paytm',
  );
  /// BHIM SBI Pay (State Bank of India's BHIM UPI app)
  static final sbiPay = UpiApplication(
    androidPackageName: 'com.sbi.upi',
    iosBundleId: 'com.sbi.upi',
    appName: 'SBI Pay',
  );
  /// iMobile by ICICI
  static final iMobile = UpiApplication(
    androidPackageName: 'com.csam.icici.bank.imobile',
    iosBundleId: 'com.icicibank.imobile',
    appName: 'iMobile',
    discoveryCustomScheme: 'imobileapp',
  );
  /// BHIM from NPCI
  static final bhim = UpiApplication(
    androidPackageName: 'in.org.npci.upiapp',
    iosBundleId: 'in.org.npci.ios.upiapp',
    appName: 'BHIM',
    discoveryCustomScheme: 'BHIM',
  );
  /// MiPay from Xiomi
  static final miPay = UpiApplication(
    androidPackageName: 'com.mipay.in.wallet',
    appName: 'Mi Pay',
  );
  /// Amazon (amazonPay signifies that the package uses the payment module)
  static final amazonPay = UpiApplication(
    androidPackageName: 'in.amazon.mShop.android.shopping',
    iosBundleId: 'com.amazon.AmazonIN',
    appName: 'Amazon Pay',
    discoveryCustomScheme: 'com.amazon.mobile.shopping',
  );
  /// Truecaller
  static final trueCaller = UpiApplication(
    androidPackageName: 'com.truecaller',
    iosBundleId: 'com.truesoftware.TrueCallerOther',
    appName: 'Truecaller',
    discoveryCustomScheme: 'truecaller',
  );
  /// Airtel Thanks
  static final airtel = UpiApplication(
    androidPackageName: 'com.myairtelapp',
    iosBundleId: 'com.BhartiMobile.myairtel',
    appName: 'Airtel',
    discoveryCustomScheme: 'myairtel',
  );
  /// BHIM Axis Pay
  static final axisPay = UpiApplication(
    androidPackageName: 'com.upi.axispay',
    iosBundleId: 'comaxisbank.axispay',
    appName: 'Axis Pay',
  );
  /// Allbank (Allahabad Bank's BHIM UPI app)
  static final bhimAllBank = UpiApplication(
    androidPackageName: 'com.lcode.allahabadupi',
    iosBundleId: 'com.alb.mobile.banking',
    appName: 'ALLBANK',
  );
  /// BHIM Andhra UPI (Andhra Bank's BHIM UPI app)
  static final bhimAndhraUpi = UpiApplication(
    androidPackageName: 'com.olive.andhra.upi',
    iosBundleId: 'com.olive.andhrabank.upi',
    appName: 'Andhra UPI',
  );
  // BHIM AUPay (AU Small Finance Bank's BHIM UPI app)
  static final bhimAuPay = UpiApplication(
    androidPackageName: 'com.aubank.aupay.bhimupi',
    iosBundleId: 'com.ausmallfinancebank.aupay.bhimupi',
    appName: 'AUPay',
  );
  /// BHIM Bandhan UPI (Bandhan Bank's BHIM UPI app)
  static final bhimBandhanUpi = UpiApplication(
    androidPackageName: 'com.fisglobal.bandhanupi.app',
    iosBundleId: 'com.bandhan.bandhanupi',
    appName: 'Bandhan UPI',
    discoveryCustomScheme: 'Bandhan',
  );
  /// BHIM BOB Pay (Bank of Baroda's BHIM UPI app)
  static final bhimBobPay = UpiApplication(
    androidPackageName: 'com.bankofbaroda.upi',
    iosBundleId: 'com.bankofbaroda.upi',
    appName: 'BOB Pay',
  );
  /// BHIM BOI UPI (Bank of India's BHIM UPI app)
  static final bhimBoiUpi = UpiApplication(
    androidPackageName: 'com.infra.boiupi',
    iosBundleId: 'com.infrasoftech.boiupi',
    appName: 'BOI UPI',
  );
  /// BHIM Cent UPI (Central Bank's BHIM UPI app)
  static final bhimCentUpi = UpiApplication(
    androidPackageName: 'com.infrasofttech.centralbankupi',
    iosBundleId: 'com.centralbank.centupi',
    appName: 'Cent UPI',
    discoveryCustomScheme: 'CentUPI',
  );
  /// BHIM CORP UPI (Corporation Bank's BHIM UPI app)
  static final bhimCorpUpi = UpiApplication(
    androidPackageName: 'com.lcode.corpupi',
    appName: 'CORP UPI',
  );
  /// BHIM CSB UPI (CSB's, formerly Catholic Syrian Bank, BHIM UPI app)
  static final bhimCsbUpi = UpiApplication(
    androidPackageName: 'com.lcode.csbupi',
    appName: 'CSB UPI',
  );
  /// BHIM CUB UPI (City Union Bank's BHIM UPI app)
  static final bhimCubUpi = UpiApplication(
    androidPackageName: 'com.cub.wallet.gui',
    appName: 'CUB UPI',
  );
  /// BHIM DCB UPI (DCB bank's BHIM UPI app)
  static final bhimDcbUpi = UpiApplication(
    androidPackageName: 'com.olive.dcb.upi',
    iosBundleId: 'com.upi.dcb',
    appName: 'DCB UPI',
  );
  /// BHIM DLB UPI (Dhanlaxmi Bank's BHIM UPI app)
  static final bhimDlbUpi = UpiApplication(
    androidPackageName: 'com.lcode.dlbupi',
    iosBundleId: 'com.lcode.dlbupi',
    appName: 'DLB UPI',
  );
  /// BHIM Equitas UPI (Equitas Small Finance Bank's BHIM UPI app)
  static final bhimEquitasUpi = UpiApplication(
    androidPackageName: 'com.equitasbank.upi',
    appName: 'Equitas UPI',
  );
  /// BHIM IDFC First Bank UPI
  static final bhimIdfcFirstBankUpi = UpiApplication(
    androidPackageName: 'com.fss.idfcpsp',
    iosBundleId: 'com.idfcbank.IDFC-UPI',
    appName: 'IDFC First Bank UPI',
  );
  /// BHIM Indian Bank UPI
  static final bhimIndianBankUpi = UpiApplication(
    androidPackageName: 'com.infrasofttech.indianbankupi',
    iosBundleId: 'com.infrasofttech.bhimindianbankupi',
    appName: 'Indian Bank UPI',
  );
  /// BHIM IndusPay (IndusInd bank's BHIM UPI app)
  static final bhimIndusPayUpi = UpiApplication(
    androidPackageName: 'com.mgs.induspsp',
    appName: 'IndusPay UPI',
  );
  /// BHIM IOB UPI (Indian Overseas Bank's BHIM UPI app)
  static final bhimIobUpi = UpiApplication(
    androidPackageName: 'com.euronet.iobupi',
    appName: 'IOB UPI',
  );
  /// BHIM JetPay (Janata Sahakari Bank's BHIM UPI app)
  static final bhimJetPay = UpiApplication(
    androidPackageName: 'com.finacus.jetpay',
    appName: 'JetPay',
  );
  /// BHIM J&K Bank UPI (Jammu & Kashmir Bank's BHIM UPI app)
  static final bhimJkBankUpi = UpiApplication(
    androidPackageName: 'com.fss.jnkpsp',
    iosBundleId: 'com.jkbank.bhimjkbankupi',
    appName: 'JK Bank UPI',
  );
  /// BHIM KBL UPI (Karnataka Bank's BHIM UPI app)
  static final bhimKblUpi = UpiApplication(
    androidPackageName: 'com.lcode.smartz',
    appName: 'KBL UPI',
  );
  /// BHIM KVB Upay (Karoor Vysya Bank's BHIM UPI app)
  static final bhimKvbUpay = UpiApplication(
    androidPackageName: 'com.mycompany.kvb',
    iosBundleId: 'kvb.app.upiapp',
    appName: 'KVB Upay',
  );
  /// BHIM LOTZA UPI (Federal Bank's LOTZA BHIM UPI app)
  static final bhimLotzaUpi = UpiApplication(
    androidPackageName: 'com.upi.federalbank.org.lotza',
    iosBundleId: 'com.upi.federalbank.org.lotza',
    appName: 'LOTZA UPI',
    discoveryCustomScheme: 'lotza',
  );
  /// BHIM LVB Upaay (Laxmi Vilas Bank's BHIM UPI app)
  static final bhimLvbUpaay = UpiApplication(
    androidPackageName: 'com.lvbank.upaay',
    iosBundleId: 'com.lvb.upaay',
    appName: 'LVB Upaay',
  );
  /// BHIM Oriental Pay (Oriental Bank of Commerce's BHIM UPI app)
  static final bhimOrientalPay = UpiApplication(
    androidPackageName: 'com.mgs.obcbank',
    appName: 'Oriental Pay',
  );
  /// BHIM Paywiz V2 (IDBI Bank's BHIM UPI app)
  static final bhimPaywizV2 = UpiApplication(
    androidPackageName: 'com.idbibank.paywiz',
    appName: 'Paywiz V2',
  );
  /// BHIM PNB (Punjab National Bank's BHIM UPI app)
  static final bhimPnb = UpiApplication(
    androidPackageName: 'com.fss.pnbpsp',
    appName: 'PNB',
  );
  /// BHIM PSB (Punjab & Sindh Bank's BHIM UPI app)
  static final bhimPsb = UpiApplication(
    androidPackageName: 'com.mobileware.upipsb',
    appName: 'PSB',
  );
  /// BHIM RBL Pay (RBL Bank's BHIM UPI app)
  static final bhimRblPay = UpiApplication(
    androidPackageName: 'com.rblbank.upi',
    iosBundleId: 'com.rblpay.upi',
    appName: 'RBL Pay',
  );
  /// BHIM@SyndUPI (Syndicate Bank's BHIM UPI app)
  static final bhimSyndUpi = UpiApplication(
    androidPackageName: 'com.fisglobal.syndicateupi.app',
    iosBundleId: 'com.syndicate.syndupi',
    appName: 'SyndUPI',
  );
  /// BHIM UCO UPI (UCO Bank's BHIM UPI app)
  static final bhimUcoUpi = UpiApplication(
    androidPackageName: 'com.lcode.ucoupi',
    iosBundleId: 'com.lcode.ucoupi',
    appName: 'UCO UPI',
    discoveryCustomScheme: 'ucoupi',
  );
  /// BHIM United UPI Pay (United Bank of India's BHIM UPI app)
  static final bhimUnitedUpiPay = UpiApplication(
    androidPackageName: 'com.fss.unbipsp',
    iosBundleId: 'com.UBI.BHIMUPI',
    appName: 'United UPI Pay',
    discoveryCustomScheme: 'upibillpay',
  );
  /// BHIM Vijaya UPI (Vijaya Bank's BHIM UPI app)
  static final bhimVijayaUpi = UpiApplication(
    androidPackageName: 'com.fss.vijayapsp',
    iosBundleId: 'com.vijayabank.UPI',
    appName: 'Vijaya UPI',
  );
  /// BHIM YesPay (Yes Bank's BHIM UPI app)
  static final bhimYesPay = UpiApplication(
    androidPackageName: 'com.YesBank',
    iosBundleId: 'com.YesPay',
    appName: 'Yes Pay',
  );
  /// BPay (Fino Payments Bank's BPay BHIM UPI app)
  static final bPay = UpiApplication(
    androidPackageName: 'com.finopaytech.bpayfino',
    iosBundleId: 'com.finopaytech.bpayfino',
    appName: 'BPay',
  );
  /// Bullet BHIM UPI payments app
  static final bullet = UpiApplication(
    androidPackageName: 'money.bullet',
    iosBundleId: 'money.bullet',
    appName: 'Bullet',
  );
  /// Canara Bank's app for account holders that also includes BHIM UPI
  /// transactions for non-customers
  static final canaraBank = UpiApplication(
    androidPackageName: 'com.canarabank.mobility',
    iosBundleId: 'com.canarabank.mobility',
    appName: 'Canara Bank App',
    discoveryCustomScheme: 'CanaraMobility',
  );
  /// Cointab BHIM UPI payments app
  static final cointab = UpiApplication(
    androidPackageName: 'in.cointab.app',
    iosBundleId: 'in.cointab.app',
    appName: 'Cointab',
  );
  /// CRED
  static final cred = UpiApplication(
    androidPackageName: 'com.dreamplug.androidapp',
    iosBundleId: 'com.dreamplug.cred',
    appName: 'CRED',
    discoveryCustomScheme: 'cred',
  );
  /// City Union Bank's app for account holders that also includes BHIM UPI
  /// transactions for non-customers
  static final cubMBankPlus = UpiApplication(
    androidPackageName: 'com.cub.plus.gui',
    iosBundleId: 'com.cub.mbank',
    appName: 'CUB mBank Plus',
  );
  /// DakPay (Indian Post Payments Bank's BHIM UPI app)
  static final dakPay = UpiApplication(
    androidPackageName: 'com.fss.ippbpsp',
    appName: 'DakPay',
  );
  /// Digibank's app for account holders that also includes BHIM UPI
  /// transactions for non-customers
  static final digibankDbs = UpiApplication(
    androidPackageName: 'com.dbs.in.digitalbank',
    iosBundleId: 'com.dbs.in.digitalbank',
    appName: 'Digibank',
    discoveryCustomScheme: 'dbin',
  );
  /// FamPay BHIM UPI app
  static final famPay = UpiApplication(
    androidPackageName: 'com.fampay.in',
    iosBundleId: 'in.fampay.app',
    appName: 'FamPay',
    discoveryCustomScheme: 'in.fampay.app',
  );
  /// Freecharge
  static final freecharge = UpiApplication(
    androidPackageName: 'com.freecharge.android',
    iosBundleId: 'com.freecharge.ios',
    appName: 'Freecharge',
    discoveryCustomScheme: 'freecharge',
  );
  /// HDFC's app for account holders that also includes BHIM UPI transactions
  /// for non-customers
  static final hdfcMobileBanking = UpiApplication(
    androidPackageName: 'com.snapwork.hdfc',
    iosBundleId: 'com.hdfcbank.mobilebanking',
    appName: 'HDFC',
    discoveryCustomScheme: 'hdfcnewbb',
  );
  /// HSBC SimplyPay (HSBC's BHIM UPI app)
  static final hsbcSimplyPay = UpiApplication(
    androidPackageName: 'com.mgs.hsbcupi',
    iosBundleId: 'com.hsbc.simplypay',
    appName: 'HSBC Simply Pay',
  );
  /// KhaaliJeb
  static final khaaliJeb = UpiApplication(
    androidPackageName: 'com.khaalijeb.inkdrops',
    appName: 'KhaaliJeb',
  );
  /// LazyPay
  static final lazyPay = UpiApplication(
    androidPackageName: 'com.citrus.citruspay',
    iosBundleId: 'com.payu.citrusapp',
    appName: 'LazyPay',
    discoveryCustomScheme: 'www.citruspay.com',
  );
  /// MahaUPI (Maharashtra Bank's BHIM UPI app)
  static final mahaUpi = UpiApplication(
    androidPackageName: 'com.infrasofttech.mahaupi',
    appName: 'MahaUPI',
  );
  /// Mobikwik
  static final mobikwik = UpiApplication(
    androidPackageName: 'com.mobikwik_new',
    iosBundleId: 'com.mobikwik',
    appName: 'Mobikwik',
    discoveryCustomScheme: 'mobikwik',
  );
  /// MudraPay payments app
  static final mudraPay = UpiApplication(
    androidPackageName: 'com.microlucid.mudrapay.android',
    appName: 'MudraPay',
  );
  /// myJio app from JIO that includes UPI payments
  static final myJio = UpiApplication(
    androidPackageName: 'com.jio.myjio',
    iosBundleId: 'com.jio.myjio',
    appName: 'MyJio',
    discoveryCustomScheme: 'myJio',
  );
  /// OmegaPay BHIM UPI app from Omegaon
  static final omegaPay = UpiApplication(
    androidPackageName: 'com.omegaon_internet_pvt_ltd',
    appName: 'Omega Pay',
  );
  /// PayZapp BHIM UPI app from HDFC
  static final payZapp = UpiApplication(
    androidPackageName: 'com.enstage.wibmo.hdfc',
    // iosBundleId: 'com.enstage.Wibmo.hdfc',
    appName: 'PayZapp',
    // discoveryCustomScheme: 'payzapp',
  );
  /// RBL's app for account holders that also includes BHIM UPI transactions for
  /// non-customers
  static final rblMoBank = UpiApplication(
    androidPackageName: 'com.rblbank.mobank',
    iosBundleId: 'com.rbl.mobilebankingiphone',
    appName: 'RBL MoBank',
    discoveryCustomScheme: 'com.rbl.rblimplicitjourney',
  );
  /// Realme PaySa BHIM UPI app
  static final realmePaySa = UpiApplication(
    androidPackageName: 'com.realmepay.payments',
    appName: 'Realme PaySa',
  );
  /// SIB Mirror+ (South Indian Bank's app for customers that also includes
  /// BHIM UPI transactions for non-customers)
  static final sibMirrorPlus = UpiApplication(
    androidPackageName: 'com.SIBMobile',
    iosBundleId: 'com.sib.sibmirrorplus',
    appName: 'SIB Mirror+',
  );
  /// Tranzapp (TJSB Sahakari Bank's BHIM UPI app)
  static final tranzappBhimUpi = UpiApplication(
    androidPackageName: 'com.finacus.tranzapp',
    appName: 'Tranzapp',
  );
  /// Ultracash
  static final ultraCash = UpiApplication(
    androidPackageName: 'com.ultracash.payment.customer',
    appName: 'UltraCash',
  );
  /// uMobile (Union Bank of India's app for customers that also includes BHIM
  /// UPI transactions for non-customers)
  static final uMobile = UpiApplication(
    androidPackageName: 'com.infrasoft.uboi',
    iosBundleId: 'com.infrasoft.uboi',
    appName: 'U-Mobile',
  );
  /// WhatsApp
  static final whatsApp = UpiApplication(
    androidPackageName: 'com.whatsapp',
    iosBundleId: 'net.whatsapp.WhatsApp',
    appName: 'WhatsApp',
    discoveryCustomScheme: 'whatsapp',
  );
  /// Yes Bank' app for customers that also includes BHIM UPI transactions for
  /// non-customers
  static final yesBank = UpiApplication(
    androidPackageName: 'com.atomyes',
    iosBundleId: 'com.yesbank',
    appName: 'Yes Mobile',
  );
  /// YuvaPay from UDMA Technologies
  static final yuvaPay = UpiApplication(
    androidPackageName: 'com.udma.yuvapay.app',
    appName: 'Yuva Pay',
  );

  static Map<String, UpiApplication> lookUpMap = {};

  /// Returns the platform-specific package name.
  String toString() {
    return io.Platform.isAndroid ? androidPackageName : iosBundleId;
  }

  /// Returns app's name.
  String getAppName() {
    return appName;
  }
}
