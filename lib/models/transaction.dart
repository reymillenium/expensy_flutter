// Packages:
import 'package:flutter/material.dart';

// Screens:

// Models:

// Components:

// Helpers:

// Utilities:

class Transaction {
  String id;
  String title;
  double amount;
  DateTime executionDate;
  DateTime createAt;
  DateTime updatedAt;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.executionDate,
    @required this.createAt,
    @required this.updatedAt,
  });
}
