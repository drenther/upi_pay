/// Represents the type of payments in the apps that user wants to access.
///
/// Passed as [paymentType] parameter of [UpiPay.getInstalledUpiApplications]
/// API.
enum UpiApplicationDiscoveryAppPaymentType {
  /// Individual-to-individual payment type. If this type is passed, then
  /// the package finds packages for which such payment works. Currently, it's
  /// the only type accepted.
  nonMerchant,

  /// Merchant payment type. Currently not accepted. Will represent merchant
  /// payment type once they are supported.
  merchant,

  /// Both individual-to-individual and merchant payment types. Not accepted
  /// currently.
  both,
}

/// Represents the UPI payment working status of apps that user wants to access.
///
/// Passed as [statusType] parameter of [UpiPay.getInstalledUpiApplications]
/// API.
enum UpiApplicationDiscoveryAppStatusType {
  /// Indicates that user wants UPI apps with any working status (they must be
  /// discoverable, though)
  all,

  /// Indicates that user wants UPI apps that complete the UPI payment and may
  /// or may not involve the "unverified source" warning. Currently, only
  /// individual-to-individual payments are implemented, and this status type
  /// is relevant for them only as some apps give this warning in the payment
  /// process and take confirmation from user before proceeding for this type
  /// of payments. For merchant payments, this type may become irrelevant.
  workingWithWarnings,

  /// Indicates that user wants UPI apps that complete the UPI payment without
  /// the "unverified source" warning
  working,
}
