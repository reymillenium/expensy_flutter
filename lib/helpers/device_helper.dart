// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:uuid/uuid.dart'; // Allows to use: Uuid
import 'package:rflutter_alert/rflutter_alert.dart'; // Allows to use: Alert
import 'package:faker/faker.dart'; // Allows to use: fake data generation (Fake)
import 'package:native_device_orientation/native_device_orientation.dart';

// Helpers:

// Utilities:

class DeviceHelper {
  // Returns the total amount of pixels in the vertical axis of the device:
  static double totalVerticalHeight({BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  // Returns the amount of pixels already used by the Status Bar in the vertical axis of the device:
  static double statusBarTopPadding({BuildContext context}) {
    return MediaQuery.of(context).padding.top;
  }

  // Returns the amount of available pixels in the vertical axis of the device:
  static double availableHeight({BuildContext context, double appBarHeight = 0}) {
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBarHeight;
  }

  // Returns how much text output in the app should be scaled. Users can change this in their mobile phone / device settings.
  static double curScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  // Returns if either the device is in Landscape position or not.
  static bool isLandscape(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.landscapeRight || orientation == NativeDeviceOrientation.landscapeLeft);
  }

  // Returns if either the device is in Portrait position or not.
  static bool isPortrait(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.portraitDown || orientation == NativeDeviceOrientation.portraitUp);
  }
}
