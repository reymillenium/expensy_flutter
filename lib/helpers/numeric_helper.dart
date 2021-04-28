// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:uuid/uuid.dart'; // Allows to use: Uuid
import 'package:rflutter_alert/rflutter_alert.dart'; // Allows to use: Alert
import 'package:faker/faker.dart'; // Allows to use: fake data generation (Fake)

// Helpers:

// Utilities:

class NumericHelper {
  static double randomDoubleInRange({double min = 0.0, double max = 1.0}) {
    return (Random().nextDouble() * (max - min)) + min;
  }

  static int randomIntegerInRange({int min = 0, int max = 1}) {
    return Random().nextInt(max - min + 1) + min;
  }

  static double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static double roundRandomDoubleInRange({double min = 0, double max = 1, int places = 0}) {
    return roundDouble(randomDoubleInRange(min: min, max: max), places);
  }

  static double biggestDoubleFromList(List<double> list) {
    return list.reduce(max);
  }
}
