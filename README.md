# upi_pay (android only)

## CAUTION: A number of popular UPI Payment Apps like Google Pay, Paytm, etc. seems to be failing with arbitrary errors due to some changes to the UPI Spec and/or compliance regulations in recent months. Use at your own risk in production scenarios as these issues can not be resolved by us. Thank you!

## (Looking for maintainers)

<img src="https://user-images.githubusercontent.com/12991390/69864983-244be680-12c6-11ea-918a-9d06c5e87110.png" height="720" width="360">

A flutter plugin to make payments by opening UPI applications using **Android Intent** and receiving the transaction information back in response.

The plugin also provides additional APIs to query and list installed applications.

[The plugins follows the UPI Deep Linking Specification](https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf)

---

## Getting Started

First, add the package to your flutter project's `pubspec.yaml` as a dependency

```yaml
dependencies:
  flutter:
    sdk: flutter
  # adding upi_pay as dependency
  upi_pay: ^0.2.0
```

Then, import the package where you need to use it

```dart
import 'package:upi_pay/upi_pay.dart';
```

---

## Documentation

### Start a UPI Transaction

You can call the `UpiPay.initiateTransaction` method to start an UPI Transaction

#### Method Call

```dart
UpiTransactionResponse txnResponse = await UpiPay.initiateTransaction(
  /// must be a string value of two decimal digits
  amount: "10.00",
  /// UpiApplication class has all the supported applications
  /// only accepts a value from the UpiApplication class
  app: UpiApplication.payTM,
  /// Name of the person / merchant receiving the payment
  receiverName: "John",
  /// UPI VPA of the person / merchant receiving the payment
  receiverUpiAddress: "johnupi@paytm",
  /// unique ID for the transaction
  /// use your business / use case specific ID generation logic here
  transactionRef: 'ORD1215236',

  /// there are some other optional parameters like
  /// [url], [merchantCode] and [transactionNode]

  /// url can be used share some additional data related to the transaction like invoice copy, etc.
  url: 'www.johnshop.com/order/ORD1215236',

  /// this is code that identifies the type of the merchant
  /// if you have a merchant UPI VPA as the receiver address
  /// add the relevant merchant code for seamless payment experience
  /// some application may reject payment intent if merchant code is missing
  /// when making a P2M (payment to merchant VPA) transaction
  merchantCode: 1032,

  /// anything that provides some desription of the transaction
  transactionNote: 'Test transaction'
)
```

#### Response

The response will be an instance of `UpiTransactionResponse`

You can access the following properties on the response instance -

- `txnId` - The Transaction ID from the PSP
- `responseCode` - The UPI response code can be used to decipher the reason for failure (if any)
- `approvalRefNo` - UPI Approval Reference Number
- `status` - This can have one of the following status values

  - `UpiTransactionStatus.Success`
  - `UpiTransactionStatus.Failure`
  - `UpiTransactionStatus.Submitted`

  Always prefer the use of `UpiTransactionStatus` enum to decipher the status of the transaction response for better code health

- `txnRef` - The transaction ref that was passed when initiating the payment. Use this value to identify which transaction the response belongs to

You can also access the raw URL response by accessing `rawResponse` on the response object

Take a look at the UPI Linking specification linked above to better understand the meaning of these fields

#### Exceptions

The method can throw the following errors -

- `InvalidUpiAddressException` - if the UPI Receiver Address is not in valid format
- `InvalidAmountException` - if the transaction amount is in invalid format (< 0 or > 1,00,000 or has more than 2 decimal digits)

### Get UPI Applications

You can list the UPI application that can handle an UPI Intent.

This API can be used to list all the UPI application on the user's device that can be used to complete an UPI transaction.

```dart
List<ApplicationMeta> upiApps = await UpiPay.getInstalledUpiApplications();
```

The `ApplicationMeta` instance has the following properties on it -

- `upiApplication` - an instance of the `UpiApplication` which can be passed as argument for the `app` parameter in `UpiPay.initiateTransaction`
- `packageName` - the package name value like `net.one97.paytm` or `com.phonepe.app`
- `icon` - stores the icon of the package in `UInt8List` format and hence can be used to render the icon as such `Image.memory(icon, width: 64, height: 64)`
- `preferredOrder` - the order of app in the UPI Intent results according to user's preference (earlier usage). This can be used to highlight the most recently used apps by the User for making UPI payments.

---

## Example

We have an [example application in the same repo](https://github.com/drenther/upi_pay/tree/master/example) and that can be used a reference
