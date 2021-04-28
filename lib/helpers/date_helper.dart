// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:uuid/uuid.dart'; // Allows to use: Uuid
import 'package:rflutter_alert/rflutter_alert.dart'; // Allows to use: Alert
import 'package:faker/faker.dart'; // Allows to use: fake data generation (Fake)

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:
import 'package:expensy_flutter/helpers/numeric_helper.dart';

// Utilities:

class DateHelper {
  static DateTime now() {
    return DateTime.now();
  }

  static DateTime timeAgo({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return DateTime.now().subtract(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  static DateTime timeFromNow({
    int microseconds = 0,
    int milliseconds = 0,
    int seconds = 0,
    int minutes = 0,
    int hours = 0,
    int days = 0,
    int years = 0,
  }) {
    int accumulatedDays = days + (years * 365);
    return DateTime.now().add(new Duration(
      microseconds: microseconds,
      milliseconds: milliseconds,
      seconds: seconds,
      minutes: minutes,
      hours: hours,
      days: accumulatedDays,
    ));
  }

  static String weekDayNow() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  static String weekDayOneDayAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 1));
  }

  static String weekDayTwoDaysAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 2));
  }

  static String weekDayThreeDaysAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 3));
  }

  static String weekDayFourDaysAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 4));
  }

  static String weekDayFiveDaysAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 5));
  }

  static String weekDaySixDaysAgo() {
    return DateFormat('EEEE').format(timeAgo(days: 6));
  }

  static DateTime randomDateTimeOnTheLastWeek() {
    final DateTime now = DateTime.now();
    return now.subtract(new Duration(days: NumericHelper.randomIntegerInRange(min: 0, max: 6)));
  }
}
