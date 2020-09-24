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
  myAirtelUpi,
  axisPay,
  // Furthers apps matching "BHIM" and "UPI" search query and from these URLs:
  // https://www.upichalega.com/upi-partners.php
  // https://www.npci.org.in/upi-PSP&3rdpartyApps
  // https://www.npci.org.in/upi-live-members
  // https://www.sebi.gov.in/sebiweb/other/OtherAction.do?doRecognisedFpi=yes&intmId=43
  allBank,
  bhimAuPay,
  bhimBandhanUpi,
  bhimBarodaPay,
  bhimBoiUpi,
  bhimCentUpi,
  bhimCorpUpi,
  bhimCsbUpi,
  bhimDcbUpi,
  bhimIndianBankUpi,
  bhimIndusPayUpi,
  bhimJetPay,
  bhimKblUpi,
  bhimKvbUpay,
  bhimLvbUpaay,
  bhimOrientalPay,
  bhimPaywizV2,
  bhimPsb,
  bhimRblPay,
  bhimSyndUpi,
  bhimUcoUpi,
  bhimVijayaUpi,
  bhimYesPay,
  bPay,
  canaraBank,
  cointab,
  freecharge,
  hsbcSimplyPay,
  khaaliJeb,
  mahaUpi,
  mobikwik,
  ultraCash,
}

class UpiApplication {
  final _UpiApplication _inner;

  UpiApplication._(this._inner);

  static final googlePay = UpiApplication._(_UpiApplication.googlePay);
  static final phonePe = UpiApplication._(_UpiApplication.phonePe);
  static final payTM = UpiApplication._(_UpiApplication.payTM);
  static final sbiPay = UpiApplication._(_UpiApplication.sbiPay);
  static final iMobileICICI = UpiApplication._(_UpiApplication.iMobileICICI);
  static final bhim = UpiApplication._(_UpiApplication.bhim);
  static final miPay = UpiApplication._(_UpiApplication.miPay);
  static final amazonPay = UpiApplication._(_UpiApplication.amazonPay);
  static final trueCallerUpi = UpiApplication._(_UpiApplication.trueCallerUpi);
  static final myAirtelUpi = UpiApplication._(_UpiApplication.myAirtelUpi);
  static final axisPay = UpiApplication._(_UpiApplication.axisPay);
  static final allBank = UpiApplication._(_UpiApplication.allBank);
  static final bhimAuPay = UpiApplication._(_UpiApplication.bhimAuPay);
  static final bhimBandhanUpi =
      UpiApplication._(_UpiApplication.bhimBandhanUpi);
  static final bhimBarodaPay = UpiApplication._(_UpiApplication.bhimBarodaPay);
  static final bhimBoiUpi = UpiApplication._(_UpiApplication.bhimBoiUpi);
  static final bhimCentUpi = UpiApplication._(_UpiApplication.bhimCentUpi);
  static final bhimCorpUpi = UpiApplication._(_UpiApplication.bhimCorpUpi);
  static final bhimCsbUpi = UpiApplication._(_UpiApplication.bhimCsbUpi);
  static final bhimDcbUpi = UpiApplication._(_UpiApplication.bhimDcbUpi);
  static final bhimIndianBankUpi =
      UpiApplication._(_UpiApplication.bhimIndianBankUpi);
  static final bhimIndusPayUpi =
      UpiApplication._(_UpiApplication.bhimIndusPayUpi);
  static final bhimJetPay = UpiApplication._(_UpiApplication.bhimJetPay);
  static final bhimKblUpi = UpiApplication._(_UpiApplication.bhimKblUpi);
  static final bhimKvbUpay = UpiApplication._(_UpiApplication.bhimKvbUpay);
  static final bhimLvbUpaay = UpiApplication._(_UpiApplication.bhimLvbUpaay);
  static final bhimOrientalPay =
      UpiApplication._(_UpiApplication.bhimOrientalPay);
  static final bhimPaywizV2 = UpiApplication._(_UpiApplication.bhimPaywizV2);
  static final bhimPsb = UpiApplication._(_UpiApplication.bhimPsb);
  static final bhimRblPay = UpiApplication._(_UpiApplication.bhimRblPay);
  static final bhimSyndUpi = UpiApplication._(_UpiApplication.bhimSyndUpi);
  static final bhimUcoUpi = UpiApplication._(_UpiApplication.bhimUcoUpi);
  static final bhimVijayaUpi = UpiApplication._(_UpiApplication.bhimVijayaUpi);
  static final bhimYesPay = UpiApplication._(_UpiApplication.bhimYesPay);
  static final bPay = UpiApplication._(_UpiApplication.bPay);
  static final canaraBank = UpiApplication._(_UpiApplication.canaraBank);
  static final cointab = UpiApplication._(_UpiApplication.cointab);
  static final freecharge = UpiApplication._(_UpiApplication.freecharge);
  static final hsbcSimplyPay = UpiApplication._(_UpiApplication.hsbcSimplyPay);
  static final khaaliJeb = UpiApplication._(_UpiApplication.khaaliJeb);
  static final mahaUpi = UpiApplication._(_UpiApplication.mahaUpi);
  static final mobikwik = UpiApplication._(_UpiApplication.mobikwik);
  static final ultraCash = UpiApplication._(_UpiApplication.ultraCash);

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
        return 'com.mipay.in.wallet';
      case _UpiApplication.amazonPay:
        return 'in.amazon.mShop.android.shopping';
      case _UpiApplication.trueCallerUpi:
        return 'com.truecaller';
      case _UpiApplication.myAirtelUpi:
        return 'com.myairtelapp';
      case _UpiApplication.axisPay:
        return 'com.upi.axispay';
      case _UpiApplication.allBank:
        return 'com.lcode.allahabadupi';
      case _UpiApplication.bhimAuPay:
        return 'com.aubank.aupay.bhimupi';
      case _UpiApplication.bhimBandhanUpi:
        return 'com.fisglobal.bandhanupi.app';
      case _UpiApplication.bhimBarodaPay:
        return 'com.bankofbaroda.upi';
      case _UpiApplication.bhimBoiUpi:
        return 'com.infra.boiupi';
      case _UpiApplication.bhimCentUpi:
        return 'com.infrasofttech.centralbankupi';
      case _UpiApplication.bhimCorpUpi:
        return 'com.lcode.corpupi';
      case _UpiApplication.bhimCsbUpi:
        return 'com.lcode.csbupi';
      case _UpiApplication.bhimDcbUpi:
        return 'com.olive.dcb.upi';
      case _UpiApplication.bhimIndianBankUpi:
        return 'com.infrasofttech.indianbankupi';
      case _UpiApplication.bhimIndusPayUpi:
        return 'com.mgs.induspsp';
      case _UpiApplication.bhimJetPay:
        return 'com.finacus.jetpay';
      case _UpiApplication.bhimKblUpi:
        return 'com.lcode.smartz';
      case _UpiApplication.bhimKvbUpay:
        return 'com.mycompany.kvb';
      case _UpiApplication.bhimLvbUpaay:
        return 'com.lvbank.upaay';
      case _UpiApplication.bhimOrientalPay:
        return 'com.mgs.obcbank';
      case _UpiApplication.bhimPaywizV2:
        return 'com.idbibank.paywiz';
      case _UpiApplication.bhimPsb:
        return 'com.mobileware.upipsb';
      case _UpiApplication.bhimRblPay:
        return 'com.rblbank.upi';
      case _UpiApplication.bhimSyndUpi:
        return 'com.fisglobal.syndicateupi.app';
      case _UpiApplication.bhimUcoUpi:
        return 'com.lcode.ucoupi';
      case _UpiApplication.bhimVijayaUpi:
        return 'com.fss.vijayapsp';
      case _UpiApplication.bhimYesPay:
        return 'com.YesBank';
      case _UpiApplication.bPay:
        return 'com.finopaytech.bpayfino';
      case _UpiApplication.canaraBank:
        return 'com.canarabank.mobility';
      case _UpiApplication.cointab:
        return 'in.cointab.app';
      case _UpiApplication.freecharge:
        return 'com.freecharge.android';
      case _UpiApplication.hsbcSimplyPay:
        return 'com.mgs.hsbcupi';
      case _UpiApplication.khaaliJeb:
        return 'com.khaalijeb.inkdrops';
      case _UpiApplication.mahaUpi:
        return 'com.infrasofttech.mahaupi';
      case _UpiApplication.mobikwik:
        return 'com.mobikwik_new';
      case _UpiApplication.ultraCash:
        return 'com.ultracash.payment.customer';
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
      case _UpiApplication.iMobileICICI:
        return 'iMobile by ICICI';
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
      case _UpiApplication.axisPay:
        return 'Axis Pay';
      case _UpiApplication.allBank:
        return 'ALLBANK';
      case _UpiApplication.bhimAuPay:
        return 'BHIM AUPay';
      case _UpiApplication.bhimBandhanUpi:
        return 'BHIM Bandhan UPI';
      case _UpiApplication.bhimBarodaPay:
        return 'BHIM Baroda Pay';
      case _UpiApplication.bhimBoiUpi:
        return 'BHIM BOI UPI';
      case _UpiApplication.bhimCentUpi:
        return 'BHIM Cent UPI';
      case _UpiApplication.bhimCorpUpi:
        return 'BHIM CORP UPI';
      case _UpiApplication.bhimCsbUpi:
        return 'BHIM CSB UPI';
      case _UpiApplication.bhimDcbUpi:
        return 'BHIM DCB UPI';
      case _UpiApplication.bhimIndianBankUpi:
        return 'BHIM IndianBank UPI';
      case _UpiApplication.bhimIndusPayUpi:
        return 'BHIM IndusPay UPI';
      case _UpiApplication.bhimJetPay:
        return 'BHIM JetPay';
      case _UpiApplication.bhimKblUpi:
        return 'BHIM KBL UPI';
      case _UpiApplication.bhimKvbUpay:
        return 'BHIM KVB Upay';
      case _UpiApplication.bhimLvbUpaay:
        return 'BHIM LVB Upaay';
      case _UpiApplication.bhimOrientalPay:
        return 'BHIM Oriental Pay';
      case _UpiApplication.bhimPaywizV2:
        return 'Bhim Paywiz V2';
      case _UpiApplication.bhimPsb:
        return 'BHIM PSB';
      case _UpiApplication.bhimRblPay:
        return 'BHIM RBL Pay';
      case _UpiApplication.bhimSyndUpi:
        return 'BHIM@SyndUPI';
      case _UpiApplication.bhimUcoUpi:
        return 'BHIM UCO UPI';
      case _UpiApplication.bhimVijayaUpi:
        return 'BHIM Vijaya UPI';
      case _UpiApplication.bhimYesPay:
        return 'BHIM Yes Pay';
      case _UpiApplication.bPay:
        return 'BPay';
      case _UpiApplication.canaraBank:
        return 'Canara Bank App';
      case _UpiApplication.cointab:
        return 'Cointab';
      case _UpiApplication.freecharge:
        return 'Freecharge';
      case _UpiApplication.hsbcSimplyPay:
        return 'HSBC Simply Pay';
      case _UpiApplication.khaaliJeb:
        return 'KhaaliJeb';
      case _UpiApplication.mahaUpi:
        return 'MahaUPI';
      case _UpiApplication.mobikwik:
        return 'Mobikwik';
      case _UpiApplication.ultraCash:
        return 'UltraCash';
      default:
        throw UnsupportedError('Invalid / Unsupported UPI Application');
    }
  }
}
