# upi_pay

Find installed UPI payment apps on your phone and make payments using any one of them.

Package implements [UPI Deep Linking And Proximity Integration Specification](https://github.com/reeteshranjan/upi_pay/files/6338127/UPI.Linking.Specs_ver.1.6.pdf).

Android | iOS
-|-
![Android Screen Capture](https://user-images.githubusercontent.com/5516599/115283164-a4e3df00-a168-11eb-878b-c3dbe6e53aa7.gif) | ![IOS Screen Capture](https://user-images.githubusercontent.com/5516599/115283187-aa412980-a168-11eb-9c03-5ae8dce30d78.gif)

## Getting Started

Add this package to your flutter project's `pubspec.yaml` as a dependency as follows:

```yaml
dependencies:
  ...
  upi_pay: ^1.0.0
```

Import the package as follows:

```dart
import 'package:upi_pay/upi_pay.dart';
```

### iOS configuration

In `Runner/Info.plist` add or modify the `LSApplicationQueriesSchemes` key so it includes custom query schemes shown as follows:

```xml
  <key>LSApplicationQueriesSchemes</key>
  <array>
    ...
    <string>freecharge</string>
    <string>gpay</string>
    <string>in.fampay.app</string>
    <string>lotza</string>
    <string>mobikwik</string>
    <string>paytm</string>
    <string>phonepe</string>
    <string>upi</string>
    <string>upibillpay</string>
    <string>whatsapp</string>
    ...
  </array>
```

### Usage

#### Get list of installed apps

```dart
final List<ApplicationMeta> appMetaList = await UpiPay.getInstalledUpiApps();
```

#### Show an app's details

```dart
Widget appWidget(ApplicationMeta appMeta) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      appMeta.iconImage(48), // Logo
      Container(
        margin: EdgeInsets.only(top: 4),
        alignment: Alignment.center,
        child: Text(
          appMeta.application.getAppName(),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
```

#### Do a UPI transaction

```dart
Future doUpiTransation(ApplicationMeta appMeta) {
  final UpiTransactionResponse response = await UpiPay.initiateTransaction(
    amount: '100.00',
    app: appMeta.application,
    receiverName: 'John Doe',
    receiverUpiAddress: 'john@doe',
    transactionRef: 'UPITXREF0001',
    transactionNote: 'A UPI Transaction',
  );
  print(response.status);
}
```

## Behaviour, Limitations & Measures

### Android

#### Flow
* On Android, the [UPI Deep Linking And Proximity Integration Specification](https://github.com/reeteshranjan/upi_pay/files/6338127/UPI.Linking.Specs_ver.1.6.pdf) is implemented using Intents.
* An Intent call with transaction request parameters includes the specific UPI app to be invoked.
* Post the UPI transaction being processed by the chosen Android UPI app, it returns a response as per the format defined in the specification to the package's Android plugin layer.
* The plugin layer parses this response to create a `UpiTransactionResponse` object that is returned to your calling code. This object clearly indicates the status of the UPI payment, i.e. was it successful, failed or being processed.

#### Measures

It is advised that you implement a server-side payment verification on top of this status reporting, to avoid being affected by any hacks in the UPI transaction workflow on client's phone.

### iOS

#### Flow

* On iOS, the [UPI Deep Linking And Proximity Integration Specification](https://github.com/reeteshranjan/upi_pay/files/6338127/UPI.Linking.Specs_ver.1.6.pdf) is implemented using iOS custom schemes.
* Each UPI payment app can listen to a payment request of the form `upi://pay?...` sent by a caller app to iOS.
* The specification does not let you specify the target app's identifier in this request. On iOS, there is no other disambiguation measure available such as any ordering of the UPI payment apps that can be retrieved using any iOS APIs. Hence, it's impossible to know which UPI payment app will be invoked.
* One of the applicable apps gets invoked and it processes the payment. The custom schemes mechanism has no way to return a transaction status to your calling code. The calling code can only know if a UPI payment app was launched successfully or not.

#### How does the package then implement `getInstalledUpiApps`?

The apps that implement any other unique custom scheme other than `upi` are discovered using such custom schemes. In the list of returned apps, both the reliably discovered apps and the supported but undetectable apps are returned.

Your code can distinguish if an app in the list of discovered apps was detected or not by checking as follows:

```dart
bool isAppReallyDiscovered(ApplicationMeta applicationMeta) {
  return applicationMeta.application.discoveryCustomScheme != null
}
```

#### Measures

* You will have to implement a payment verification on top of functionality available through this package.
* You should distinguish discovered and supported-only apps using the mechanism in the above section. The example app can be used for reference.

## UPI Apps' Functional Status Dynamics

UPI standards and systems are evolving, and accordingly behaviour and functionality of the UPI payment apps are changing. See [Apps](https://github.com/reeteshranjan/upi_pay/blob/master/APPS.md) for details of current functional status of various applications that were verified by us.

### Support for merchant and non-merchant payments

The [UPI Deep Linking And Proximity Integration Specification](https://github.com/reeteshranjan/upi_pay/files/6338127/UPI.Linking.Specs_ver.1.6.pdf) is designed for merchant payments. It includes parameters in payment request that can be provided only if the payment was made to a merchant e.g. the merchant code (`mc` parameter), and a signature (crypto-hash) of the request created using merchant's private key.

However; various applications have been accepting requests without merchant details and signature and successfully processing payments. Possibly, the dilution could be due to the reason that such a package can only automate filling a payment form, and unless the user verifies the details in the form and enters the UPI pin, no damaging payments can be really made.

Over last few months, few applications have started changing their behaviour around non-merchant payments and one or more of the following are seen in few apps:

* An implicit "unverified source" warning or a direct warning indicating that merchant data in the request is not correct
* Z7 error, "Transaction Frequency Limit Exceeded": See [UPI Error and Response Codes](https://github.com/reeteshranjan/upi_pay/files/6338492/PHN6WKI7_UPI_Error_and_Response_Codes_V_2_3_1.pdf)
* U16 error, "Risk Threshold Exceeded", see [UPI Error and Response Codes](https://github.com/reeteshranjan/upi_pay/files/6338492/PHN6WKI7_UPI_Error_and_Response_Codes_V_2_3_1.pdf)
* An implicit "Security error"

This behaviour sometimes is not consistent even for the same app. For example, WhatsApp successfully completes transactions on iOS; but rejects non-merchant transactions on Android.

If you believe that your app's users' money is secure via their UPI pin, and you can let them use apps that successfully complete non-merchant transactions, then go ahead and pick the working apps in [Apps](https://github.com/reeteshranjan/upi_pay/blob/master/APPS.md) and integrate this package.

### Regressions

It's seen that post the Bank mergers of 2020-21 some of the bank apps have stopped working, even though they are still in Play Store and/or App Store.

### iOS minimum versions

Several BHIM apps have stopped working on <iOS 13.5. This package's iOS support is verified on iPhone with iOS 14+.

### Love to experiment yourself?

Default behaviour of the `getInstalledUpiApps` API is to give you only the completely successfully working UPI apps. You can make the package return other apps by passing relevant values for parameters of this API. Please see API documentation. To support this experimentation, we would add further tweaking to allow you to access UPI apps not seen and supported by this package shortly on Android.
