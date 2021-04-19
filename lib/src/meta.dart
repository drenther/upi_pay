import 'dart:io';
import 'dart:typed_data';

import 'package:upi_pay/src/applications.dart';
import 'package:flutter/material.dart';

/// Represents a UPI payment app and more relevant information.
///
/// Contains [UpiApplication] representation of the UPI payment app. Also
/// contains a logo image and other data.
class ApplicationMeta {
  /// Android platform constructor.
  ///
  /// Stores the byte-array version of the logo apart from [_priority] and
  /// [_preferredOrder].
  ApplicationMeta.android(
    this.upiApplication,
    this._icon,
    this._priority,
    this._preferredOrder,
  );

  /// iOS platform constructor.
  ApplicationMeta.ios(
    this.upiApplication,
  )   : _icon = null,
        _priority = 0,
        _preferredOrder = 0;

  /// Returns an [Image] widget for the UPI app.
  ///
  /// [dimension] specifies width and height of the [Image] output.
  ///
  /// On Android, it creates an [Image] widget from the byte-array of the logo.
  /// On iOS, it creates an [Image] widget from logo stored as part of assets.
  Image iconImage(double dimension) {
    if (Platform.isAndroid) {
      return Image.memory(_icon, width: dimension, height: dimension);
    } else if (Platform.isIOS) {
      return Image.asset(
        'assets/apps/ios/${upiApplication.iosBundleId}.png',
        package: 'upi_pay',
        width: dimension,
        height: dimension,
      );
    }
    throw UnsupportedError('`iconImage` is available on Android and iOS only');
  }

  /// Gets the UPI app's package name.
  String get packageName => upiApplication.toString();

  /// Getter for [_priority]. Leads to [UnsupportedError] on iOS.
  int get priority {
    if (Platform.isAndroid) {
      return _priority;
    }
    throw UnsupportedError('`priority` is not available on iOS');
  }

  /// Getter for [_preferredOrder]. Leads to [UnsupportedError] on iOS.
  int get preferredOrder {
    if (Platform.isAndroid) {
      return _preferredOrder;
    }
    throw UnsupportedError('`preferredOrder` is not available on iOS');
  }

  @Deprecated('Use the `iconImage` cross-platform API instead')
  Uint8List get icon => _icon;

  /// [UpiApplication] representation of the UPI app.
  final UpiApplication upiApplication;

  /// The byte-array version of the app's logo (Android-only).
  final Uint8List _icon;

  /// Priority of execution. Provided for API response coverage (Android-only).
  /// Not used as of now.
  final int _priority;

  /// Preferred order of execution. Provided for API response coverage
  /// (Android-only). Not used as of now.
  final int _preferredOrder;
}
