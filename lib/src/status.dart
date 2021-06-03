class UpiApplicationStatus {
  final UpiApplicationAndroidStatus androidStatus;
  final UpiApplicationIosStatus? iosStatus;
  UpiApplicationStatus({
    required this.androidStatus,
    required this.iosStatus,
  });

  static final UpiApplicationStatus googlePay = UpiApplicationStatus(
    androidStatus: _androidSatusDailyTxnLimitExceeded,
    iosStatus: _iosStatusDailyTxnLimitExceeded,
  );
  static final UpiApplicationStatus phonePe = UpiApplicationStatus(
    androidStatus: _androidStatusSecurityError,
    iosStatus: _iosStatusSecurityError,
  );
  static final UpiApplicationStatus paytm = UpiApplicationStatus(
    androidStatus: _androidSatusDailyTxnLimitExceeded,
    iosStatus: _iosStatusWorks,
  );
  static final UpiApplicationStatus sbiPay = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFailsWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus iMobile = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhim = UpiApplicationStatus(
    androidStatus: _androidStatusRiskThresholdExceeded,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus miPay = UpiApplicationStatus(
    androidStatus: _androidStatusNoReturn,
    iosStatus: null,
  );
  static final UpiApplicationStatus amazonPay = UpiApplicationStatus(
    androidStatus: _androidSatusDailyTxnLimitExceeded,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus trueCaller = UpiApplicationStatus(
    androidStatus: _androidStatusUpiDisabledNoIntent,
    iosStatus: _iosStatusUpiDisabledNoUpiScheme,
  );
  static final UpiApplicationStatus airtel = UpiApplicationStatus(
    androidStatus: _androidStatusNoReturn,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus axisPay = UpiApplicationStatus(
    androidStatus: _androidStatusNoReturn,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimAllBank = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscovered,
    iosStatus: _iosStatusUnstableNoUpiScheme,
  );
  static final UpiApplicationStatus bhimAndhraUpi = UpiApplicationStatus(
    androidStatus: _androidStatusVerifySmsFailsDiscovered,
    iosStatus: _iosStatusVerifySmsFailsNoUpiScheme,
  );
  static final UpiApplicationStatus bhimAuPay = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFailsWithSecurityWarning,
    iosStatus: _iosStatusWorksWithSecurityWarning,
  );
  static final UpiApplicationStatus bhimBandhanUpi = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFailsWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimBobPay = UpiApplicationStatus(
    androidStatus: _androidStatusRiskThresholdExceeded,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimBoiUpi = UpiApplicationStatus(
    androidStatus: _androidStatusNoReturnWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimCentUpi = UpiApplicationStatus(
    androidStatus: _androidStatusFormNotShownWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimCorpUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscovered,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimCsbUpi = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimCubUpi = UpiApplicationStatus(
    androidStatus: _androidStatusWorksWithSecurityWarning,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimDcbUpi = UpiApplicationStatus(
    androidStatus: _androidStatusWorksWithSecurityWarning,
    iosStatus: _iosStatusVerifySmsFailsNoUpiScheme,
  );
  static final UpiApplicationStatus bhimDlbUpi = UpiApplicationStatus(
    androidStatus: _androidStatusRiskThresholdExceeded,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimEquitasUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableForIntentCalls,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimIdfcFirstBankUpi = UpiApplicationStatus(
    androidStatus: _androidStatusBailsOutWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimIndianBankUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscovered,
    iosStatus: _iosStatusUnstableNoUpiScheme,
  );
  static final UpiApplicationStatus bhimIndusPayUpi = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFailsWithSecurityWarning,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimIobUpi = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscovered,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimJetPay = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableForIntentCalls,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimJkBankUpi = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscoveryFails,
    iosStatus: _iosStatusVerifyFailsHasUpiScheme,
  );
  static final UpiApplicationStatus bhimKblUpi = UpiApplicationStatus(
    androidStatus: _androidStatusBailsOutWithSecurityWarning,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimKvbUpay = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFails,
    iosStatus: _iosStatusFormNotShown,
  );
  static final UpiApplicationStatus bhimLotzaUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableForIntentCalls,
    iosStatus: _iosStatusPaymentFails,
  );
  static final UpiApplicationStatus bhimLvbUpaay = UpiApplicationStatus(
    androidStatus: _androidStatusVerifySmsFailsDiscovered,
    iosStatus: _iosStatusVerifyFailsNoUpiScheme,
  );
  static final UpiApplicationStatus bhimOrientalPay = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscovered,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimPaywizV2 = UpiApplicationStatus(
    androidStatus: _androidStatusPostSetupErrorAndDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimPnb = UpiApplicationStatus(
    androidStatus: _androidStatusPostSetupErrorDiscovered,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimPsb = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscovered,
    iosStatus: null,
  );
  static final UpiApplicationStatus bhimRblPay = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableForIntentCalls,
    iosStatus: _iosStatusPostSetupErrorNoUpiScheme,
  );
  static final UpiApplicationStatus bhimSyndUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableDiscoveryFails,
    iosStatus: _iosStatusUnstableHasUpiScheme,
  );
  static final UpiApplicationStatus bhimUcoUpi = UpiApplicationStatus(
    androidStatus: _androidStatusUnstableForIntentCalls,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus bhimUnitedUpiPay = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscoveryFails,
    iosStatus: _iosStatusVerifyFailsHasUpiScheme,
  );
  static final UpiApplicationStatus bhimVijayaUpi = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscovered,
    iosStatus: _iosStatusVerifyFailsHasUpiScheme,
  );
  static final UpiApplicationStatus bhimYesPay = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: _iosStatusVerifyFailsNoUpiScheme,
  );
  static final UpiApplicationStatus bPay = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscoveryFails,
    iosStatus: _iosStatusUpiDisabledNoUpiScheme,
  );
  static final UpiApplicationStatus bullet = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFails,
    iosStatus: _iosStatusIncompleteForm,
  );
  static final UpiApplicationStatus canaraBank = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFailsWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus cointab = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: _iosStatusWorks,
  );
  static final UpiApplicationStatus cred = UpiApplicationStatus(
    androidStatus: _androidStatusRiskThresholdExceeded,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus cubMBankPlus = UpiApplicationStatus(
    androidStatus: _androidStatusUpiSupportedNoIntent,
    iosStatus: _iosStatusForCustomerOnlyNoUpiScheme,
  );
  static final UpiApplicationStatus dakPay = UpiApplicationStatus(
    androidStatus: _androidStatusUnderMaintenanceDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus digibankDbs = UpiApplicationStatus(
    androidStatus: _androidStatusForCustomersOnlyDiscovered,
    iosStatus: _iosStatusForCustomerOnlyNoUpiScheme,
  );
  static final UpiApplicationStatus famPay = UpiApplicationStatus(
    androidStatus: _androidStatusUpiDisabledDiscovered,
    iosStatus: _iosStatusUpiDisabledHasUpiScheme,
  );
  static final UpiApplicationStatus freecharge = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: _iosStatusWorks,
  );
  static final UpiApplicationStatus hdfcMobileBanking = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscovered,
    iosStatus: _iosStatusUpiSetupFailsNoUpiScheme,
  );
  static final UpiApplicationStatus hsbcSimplyPay = UpiApplicationStatus(
    androidStatus: _androidStatusNoUpiRefWithSecurityWarning,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus khaaliJeb = UpiApplicationStatus(
    androidStatus: _androidStatusUpiDisabledDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus lazyPay = UpiApplicationStatus(
    androidStatus: _androidStatusRegistrationIncompleteDiscovered,
    iosStatus: _iosStatusRegistrationIncompleteNoUpiScheme,
  );
  static final UpiApplicationStatus mahaUpi = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: null,
  );
  static final UpiApplicationStatus mobikwik = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: _iosStatusWorks,
  );
  static final UpiApplicationStatus mudraPay = UpiApplicationStatus(
    androidStatus: _androidStatusUpiSetupFailsDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus myJio = UpiApplicationStatus(
    androidStatus: _androidStatusNoReturn,
    iosStatus: _iosStatusUpiSupportedNoUpiScheme,
  );
  static final UpiApplicationStatus omegaPay = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: null,
  );
  static final UpiApplicationStatus payZapp = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus rblMoBank = UpiApplicationStatus(
    androidStatus: _androidStatusIncompleteForm,
    iosStatus: _iosStatusUpiDisabledNoUpiScheme,
  );
  static final UpiApplicationStatus realmePaySa = UpiApplicationStatus(
    androidStatus: _androidStatusUpiDisabledDiscoveryFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus sibMirrorPlus = UpiApplicationStatus(
    androidStatus: _androidStatusVerifyFailsDiscoveryFails,
    iosStatus: _iosStatusPostSetupErrorNoUpiScheme,
  );
  static final UpiApplicationStatus tranzappBhimUpi = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus ultracash = UpiApplicationStatus(
    androidStatus: _androidStatusPaymentFails,
    iosStatus: null,
  );
  static final UpiApplicationStatus uMobile = UpiApplicationStatus(
    androidStatus: _androidStatusForCustomersOnlyDiscovered,
    iosStatus: _iosStatusForCustomerOnlyNoUpiScheme,
  );
  static final UpiApplicationStatus whatsApp = UpiApplicationStatus(
    androidStatus: _androidStatusBailsOut,
    iosStatus: _iosStatusWorks,
  );
  static final UpiApplicationStatus yesBank = UpiApplicationStatus(
    androidStatus: _androidStatusForCustomersOnlyDiscovered,
    iosStatus: _iosStatusForCustomerOnlyNoUpiScheme,
  );
  static final UpiApplicationStatus yuvaPay = UpiApplicationStatus(
    androidStatus: _androidStatusWorks,
    iosStatus: null,
  );
}

final _androidStatusWorks = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.success,
);

final _androidStatusWorksWithSecurityWarning = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.success,
);

final _androidStatusNoUpiRefWithSecurityWarning = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.noUpiTxnRef,
);

final _androidStatusNoReturn = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.noReturn,
);

final _androidStatusNoReturnWithSecurityWarning = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.noReturn,
);

final _androidStatusPaymentFails = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.paymentFails,
);

final _androidStatusPaymentFailsWithSecurityWarning =
    UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.paymentFails,
);

final _androidSatusDailyTxnLimitExceeded = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus:
      NonMerchantPaymentAndroidStatus.dailyTxnLimitExceeded,
);

final _androidStatusRiskThresholdExceeded = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus:
      NonMerchantPaymentAndroidStatus.riskThresholdExceeded,
);

final _androidStatusSecurityError = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.securityError,
);

final _androidStatusIncompleteForm = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.formIncomplete,
);

final _androidStatusFormNotShownWithSecurityWarning =
    UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentAndroidStatus.formNotShown,
);

final _androidStatusBailsOut = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus:
      NonMerchantPaymentAndroidStatus.bailsOutWithParamsErrors,
);

final _androidStatusBailsOutWithSecurityWarning = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus:
      NonMerchantPaymentAndroidStatus.bailsOutWithParamsErrors,
);

final _androidStatusUnstableForIntentCalls = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus:
      NonMerchantPaymentAndroidStatus.unstableOnIntentCall,
);

final _androidStatusUpiSupportedNoIntent = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _androidStatusRegistrationIncompleteDiscovered =
    UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.registrationIncomplete,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusForCustomersOnlyDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.forCustomersOnly,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusPostSetupErrorDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.postSetupError,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusPostSetupErrorAndDiscoveryFails =
    UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.postSetupError,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUpiSetupFailsDiscoveryFails = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.upiRegistrationFails,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _androidStatusVerifyFailsDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.verifyFails,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusVerifyFailsDiscoveryFails = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.verifyFails,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _androidStatusVerifySmsFailsDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.verifySmsFails,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUnderMaintenanceDiscoveryFails =
    UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.underMaintenance,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUpiDisabledDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.upiDisabled,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUpiDisabledDiscoveryFails = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.upiDisabled,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUpiDisabledNoIntent = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.upiDisabled,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUnstableDiscovered = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.unstable,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _androidStatusUnstableDiscoveryFails = UpiApplicationAndroidStatus(
  setup: UpiApplicationSetupStatus.unstable,
  linkingSupport: UpiApplicationLinkingSupport.nowShowingUp,
  nonMerchantPaymentStatus: null,
);

final _iosStatusWorks = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.success,
);

final _iosStatusWorksWithSecurityWarning = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  warnsUnverifiedSourceForNonMerchant: true,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.success,
);

final _iosStatusDailyTxnLimitExceeded = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.dailyTxnLimitExceeded,
);

final _iosStatusSecurityError = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.securityError,
);

final _iosStatusPaymentFails = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.paymentFails,
);

final _iosStatusFormNotShown = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.formNotShown,
);

final _iosStatusIncompleteForm = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: NonMerchantPaymentIosStatus.formIncomplete,
);

final _iosStatusUpiSupportedNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.success,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusForCustomerOnlyNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.forCustomersOnly,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusRegistrationIncompleteNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.registrationIncomplete,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusPostSetupErrorNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.postSetupError,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusUpiSetupFailsNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.upiRegistrationFails,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusVerifyFailsHasUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.verifyFails,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _iosStatusVerifyFailsNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.verifyFails,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusVerifySmsFailsNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.verifySmsFails,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusUpiDisabledHasUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.upiDisabled,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _iosStatusUpiDisabledNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.upiDisabled,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

final _iosStatusUnstableHasUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.unstable,
  linkingSupport: UpiApplicationLinkingSupport.shows,
  nonMerchantPaymentStatus: null,
);

final _iosStatusUnstableNoUpiScheme = UpiApplicationIosStatus(
  setup: UpiApplicationSetupStatus.unstable,
  linkingSupport: UpiApplicationLinkingSupport.absent,
  nonMerchantPaymentStatus: null,
);

class UpiApplicationAndroidStatus extends UpiApplicationPlatformStatus {
  final NonMerchantPaymentAndroidStatus? nonMerchantPaymentStatus;
  UpiApplicationAndroidStatus({
    required UpiApplicationSetupStatus setup,
    required UpiApplicationLinkingSupport linkingSupport,
    bool warnsUnverifiedSourceForNonMerchant: false,
    this.nonMerchantPaymentStatus,
  }) : super(
            setup: setup,
            linkingSupport: linkingSupport,
            warnsUnverifiedSourceForNonMerchant:
                warnsUnverifiedSourceForNonMerchant);
}

class UpiApplicationIosStatus extends UpiApplicationPlatformStatus {
  final NonMerchantPaymentIosStatus? nonMerchantPaymentStatus;
  UpiApplicationIosStatus({
    required UpiApplicationSetupStatus setup,
    required UpiApplicationLinkingSupport linkingSupport,
    bool warnsUnverifiedSourceForNonMerchant: false,
    this.nonMerchantPaymentStatus,
  }) : super(
            setup: setup,
            linkingSupport: linkingSupport,
            warnsUnverifiedSourceForNonMerchant:
                warnsUnverifiedSourceForNonMerchant);
}

class UpiApplicationPlatformStatus {
  final UpiApplicationSetupStatus setup;
  final UpiApplicationLinkingSupport linkingSupport;
  final bool warnsUnverifiedSourceForNonMerchant;

  UpiApplicationPlatformStatus({
    required this.setup,
    required this.linkingSupport,
    this.warnsUnverifiedSourceForNonMerchant: false,
  });
}

enum UpiApplicationSetupStatus {
  unstable,
  underMaintenance,
  upiDisabled,
  verifySmsFails,
  verifyFails,
  registrationIncomplete, // User-specific status that should not be here
  upiRegistrationFails,
  forCustomersOnly,
  postSetupError,
  success,
}

// Represents whether the app can be invoked directly as of now though
// Intents on Android and custom schemes on iOS
enum UpiApplicationLinkingSupport {
  absent,
  nowShowingUp,
  shows,
}

// Represents the status of making individual payments though an Android app
enum NonMerchantPaymentAndroidStatus {
  unstableOnIntentCall,
  bailsOutWithParamsErrors,
  formNotShown,
  formIncomplete,
  paymentFails,
  paymentParamsError,
  securityError,
  riskThresholdExceeded,
  dailyTxnLimitExceeded,
  noReturn,
  noUpiTxnRef,
  success,
}

// Represents the status of making individual payments through an iOS app
enum NonMerchantPaymentIosStatus {
  unstableForInvoking,
  launchBailsOutWithParamsErrors,
  formNotShown,
  formIncomplete,
  paymentFails,
  paymentParamsError,
  securityError,
  riskThresholdExceeded,
  dailyTxnLimitExceeded,
  success,
}
