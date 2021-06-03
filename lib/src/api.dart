import 'dart:async';

// for meta
import 'package:flutter/material.dart';
import 'package:upi_pay/src/discovery.dart';
import 'package:upi_pay/src/meta.dart';
import 'package:upi_pay/src/method_channel.dart';
import 'package:upi_pay/src/response.dart';
import 'package:upi_pay/src/status.dart';
import 'package:upi_pay/src/applications.dart';
import 'package:upi_pay/src/exceptions.dart';
import 'package:upi_pay/src/transaction.dart';
import 'package:upi_pay/src/transaction_details.dart';

/// Helps with getting installed UPI apps and making payments using them.
///
/// The [getInstalledUpiApplications] API helps getting installed applications.
///
/// The [initiateTransaction] API helps with making a transaction using a chosen
/// UPI payment app.
class UpiPay {
  static final UpiMethodChannel _channel = UpiMethodChannel();
  static final UpiApplicationDiscovery _discovery = UpiApplicationDiscovery();
  static final UpiTransactionHelper _transactionHelper = UpiTransactionHelper();

  /// Start a UPI Transaction.
  ///
  /// The parameters correspond to respective parameters in the
  /// [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf).
  /// Their names as appearing in the specification have been mentioned.
  ///
  /// [app] represents a UPI payment app. One of the static members of
  /// [UpiApplication].
  ///
  /// [receiverUpiAddress] is recipient UPI VPA. An invalid value will result
  /// in [InvalidUpiAddressException]. See `pa` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf).
  ///
  /// [receiverName] is the name of the recipient. See `pn` in specification.
  ///
  /// [transactionRef] is an ID (typically unique if you need to
  /// identify each payment) for the UPI transaction. On Android its value is
  /// copied back in the response from the UPI payment app. See `tr` in
  /// [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf).
  ///
  /// [amount] must be a string form of payment amount and must be valid
  /// currency (no more than 2 digits after decimal). The package also limits
  /// it to be <=1,00,000. An unacceptable value leads to
  /// [InvalidAmountException]. Some UPI payment apps or your payer account
  /// may have their own permanent or daily limits, which this package cannot
  /// control towards ensuring payment. See `am` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf).
  ///
  /// [transactionNote] is a short description of the transaction. See `tn` in
  /// [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf).
  ///
  /// [url]: See `url` parameter in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)
  static Future<UpiTransactionResponse> initiateTransaction({
    @required UpiApplication app,
    @required String receiverUpiAddress,
    @required String receiverName,
    @required String transactionRef,
    @required String amount,
    String url,
    String transactionNote,
  }) async {
    final transactionDetails = TransactionDetails(
      upiApplication: app,
      payeeAddress: receiverUpiAddress,
      payeeName: receiverName,
      transactionRef: transactionRef,
      amount: amount,
      url: url,
      transactionNote: transactionNote,
    );
    return await _transactionHelper.transact(_channel, transactionDetails);
  }

  /// Finds installed UPI payment applications.
  ///
  /// Default behaviour is to present all applications verified to be working
  /// properly.
  ///
  /// [statusType] can be used to change the default behaviour. Setting it to
  /// [UpiApplicationDiscoveryAppStatusType.workingWithWarnings] will fetch
  /// all apps that work but produce a "unverified source" or relevant error
  /// caused due to lack of using the merchant's signature parameter in this
  /// package (See `mc` and `sign` in [UPI Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)).
  /// Currently this package does not implement merchant payments as per the
  /// specification, and rather helps with individual-to-individual payments
  /// that do not require merchant details. It's an upcoming feature. Setting
  /// [statusType] to [UpiApplicationDiscoveryAppStatusType.all] will fetch all
  /// the apps. UPI researchers can use this value to experiment with the
  /// UPI apps this package can detect.
  ///
  /// [paymentType] must be [UpiApplicationDiscoveryAppPaymentType.nonMerchant]
  /// for now. Setting it to any other value will lead to [UnsupportedError].
  static Future<List<ApplicationMeta>> getInstalledUpiApplications({
    UpiApplicationDiscoveryAppPaymentType paymentType:
        UpiApplicationDiscoveryAppPaymentType.nonMerchant,
    UpiApplicationDiscoveryAppStatusType statusType:
        UpiApplicationDiscoveryAppStatusType.working,
  }) async {
    if (paymentType != UpiApplicationDiscoveryAppPaymentType.nonMerchant) {
      throw UnsupportedError('The parameter `paymentType` must be '
          '`UpiApplicationDiscoveryAppPaymentType.nonMerchant`');
    }
    if (_upiApplicationStatuses.isEmpty) {
      return [];
    }
    return await _discovery.discover(
      upiMethodChannel: _channel,
      applicationStatusMap: _upiApplicationStatuses,
      paymentType: paymentType,
      statusType: statusType,
    );
  }

  static final Map<UpiApplication, UpiApplicationStatus>
      _upiApplicationStatuses = {
    UpiApplication.googlePay: UpiApplicationStatus.googlePay,
    UpiApplication.phonePe: UpiApplicationStatus.phonePe,
    UpiApplication.paytm: UpiApplicationStatus.paytm,
    UpiApplication.sbiPay: UpiApplicationStatus.sbiPay,
    UpiApplication.iMobile: UpiApplicationStatus.iMobile,
    UpiApplication.bhim: UpiApplicationStatus.bhim,
    UpiApplication.miPay: UpiApplicationStatus.miPay,
    UpiApplication.amazonPay: UpiApplicationStatus.amazonPay,
    UpiApplication.trueCaller: UpiApplicationStatus.trueCaller,
    UpiApplication.airtel: UpiApplicationStatus.airtel,
    UpiApplication.axisPay: UpiApplicationStatus.axisPay,
    UpiApplication.bhimAllBank: UpiApplicationStatus.bhimAllBank,
    UpiApplication.bhimAndhraUpi: UpiApplicationStatus.bhimAndhraUpi,
    UpiApplication.bhimAuPay: UpiApplicationStatus.bhimAuPay,
    UpiApplication.bhimBandhanUpi: UpiApplicationStatus.bhimBandhanUpi,
    UpiApplication.bhimBobPay: UpiApplicationStatus.bhimBobPay,
    UpiApplication.bhimBoiUpi: UpiApplicationStatus.bhimBoiUpi,
    UpiApplication.bhimCentUpi: UpiApplicationStatus.bhimCentUpi,
    UpiApplication.bhimCorpUpi: UpiApplicationStatus.bhimCorpUpi,
    UpiApplication.bhimCsbUpi: UpiApplicationStatus.bhimCsbUpi,
    UpiApplication.bhimCubUpi: UpiApplicationStatus.bhimCubUpi,
    UpiApplication.bhimDcbUpi: UpiApplicationStatus.bhimDcbUpi,
    UpiApplication.bhimDlbUpi: UpiApplicationStatus.bhimDlbUpi,
    UpiApplication.bhimEquitasUpi: UpiApplicationStatus.bhimEquitasUpi,
    UpiApplication.bhimIdfcFirstBankUpi:
        UpiApplicationStatus.bhimIdfcFirstBankUpi,
    UpiApplication.bhimIndianBankUpi: UpiApplicationStatus.bhimIndianBankUpi,
    UpiApplication.bhimIndusPayUpi: UpiApplicationStatus.bhimIndusPayUpi,
    UpiApplication.bhimIobUpi: UpiApplicationStatus.bhimIobUpi,
    UpiApplication.bhimJetPay: UpiApplicationStatus.bhimJetPay,
    UpiApplication.bhimJkBankUpi: UpiApplicationStatus.bhimJkBankUpi,
    UpiApplication.bhimKblUpi: UpiApplicationStatus.bhimKblUpi,
    UpiApplication.bhimKvbUpay: UpiApplicationStatus.bhimKvbUpay,
    UpiApplication.bhimLotzaUpi: UpiApplicationStatus.bhimLotzaUpi,
    UpiApplication.bhimLvbUpaay: UpiApplicationStatus.bhimLvbUpaay,
    UpiApplication.bhimOrientalPay: UpiApplicationStatus.bhimOrientalPay,
    UpiApplication.bhimPaywizV2: UpiApplicationStatus.bhimPaywizV2,
    UpiApplication.bhimPnb: UpiApplicationStatus.bhimPnb,
    UpiApplication.bhimPsb: UpiApplicationStatus.bhimPsb,
    UpiApplication.bhimRblPay: UpiApplicationStatus.bhimRblPay,
    UpiApplication.bhimSyndUpi: UpiApplicationStatus.bhimSyndUpi,
    UpiApplication.bhimUcoUpi: UpiApplicationStatus.bhimUcoUpi,
    UpiApplication.bhimUnitedUpiPay: UpiApplicationStatus.bhimUnitedUpiPay,
    UpiApplication.bhimVijayaUpi: UpiApplicationStatus.bhimVijayaUpi,
    UpiApplication.bhimYesPay: UpiApplicationStatus.bhimYesPay,
    UpiApplication.bPay: UpiApplicationStatus.bPay,
    UpiApplication.bullet: UpiApplicationStatus.bullet,
    UpiApplication.canaraBank: UpiApplicationStatus.canaraBank,
    UpiApplication.cointab: UpiApplicationStatus.cointab,
    UpiApplication.cred: UpiApplicationStatus.cred,
    UpiApplication.cubMBankPlus: UpiApplicationStatus.cubMBankPlus,
    UpiApplication.dakPay: UpiApplicationStatus.dakPay,
    UpiApplication.digibankDbs: UpiApplicationStatus.digibankDbs,
    UpiApplication.famPay: UpiApplicationStatus.famPay,
    UpiApplication.freecharge: UpiApplicationStatus.freecharge,
    UpiApplication.hdfcMobileBanking: UpiApplicationStatus.hdfcMobileBanking,
    UpiApplication.hsbcSimplyPay: UpiApplicationStatus.hsbcSimplyPay,
    UpiApplication.khaaliJeb: UpiApplicationStatus.khaaliJeb,
    UpiApplication.lazyPay: UpiApplicationStatus.lazyPay,
    UpiApplication.mahaUpi: UpiApplicationStatus.mahaUpi,
    UpiApplication.mobikwik: UpiApplicationStatus.mobikwik,
    UpiApplication.mudraPay: UpiApplicationStatus.mudraPay,
    UpiApplication.myJio: UpiApplicationStatus.myJio,
    UpiApplication.omegaPay: UpiApplicationStatus.omegaPay,
    UpiApplication.payZapp: UpiApplicationStatus.payZapp,
    UpiApplication.rblMoBank: UpiApplicationStatus.rblMoBank,
    UpiApplication.realmePaySa: UpiApplicationStatus.realmePaySa,
    UpiApplication.sibMirrorPlus: UpiApplicationStatus.sibMirrorPlus,
    UpiApplication.tranzappBhimUpi: UpiApplicationStatus.tranzappBhimUpi,
    UpiApplication.ultraCash: UpiApplicationStatus.ultracash,
    UpiApplication.uMobile: UpiApplicationStatus.uMobile,
    UpiApplication.whatsApp: UpiApplicationStatus.whatsApp,
    UpiApplication.yesBank: UpiApplicationStatus.yesBank,
    UpiApplication.yuvaPay: UpiApplicationStatus.yuvaPay,
  };
}
