// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:uuid/uuid.dart'; // Allows to use: Uuid

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:

// Utilities:

class TransactionsData {
  // Properties:
  List<Transaction> _transactions = [];

  // Constructor:
  TransactionsData() {
    DateTime now = DateTime.now();
    var uuid = Uuid();
    // transactions = List<Transaction>.generate(5, (index) {
    //   return Transaction(
    //     id: 't$index',
    //     title: _getRandomString(6),
    //     amount: _roundDouble(_randomDoubleInRange(min: 1.0, max: 99.0), 2),
    //     createAt: now,
    //     updatedAt: now,
    //   );
    // });

    for (int i = 0; i < 5; i++) {
      Transaction newTransaction = Transaction(
        // id: 't$i',
        id: '${uuid.v1()}',
        title: _getRandomString(12),
        // amount: randomDoubleInRange(min: 1.0, max: 100.0),
        amount: _roundDouble(_randomDoubleInRange(min: 1.0, max: 99.0), 2),
        executionDate: now,
        createAt: now,
        updatedAt: now,
      );
      _transactions.add(newTransaction);
    }
  }

  // Getters:
  get transactions {
    return _transactions;
  }

  // Private methods:
  String _getRandomString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  double _randomDoubleInRange({double min = 0.0, double max = 1.0}) {
    return Random().nextDouble() * (max - min + 1) + min;
  }

  double _roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  // Public methods:
  void addTransaction(String title, double amount, DateTime executionDate) {
    DateTime now = DateTime.now();
    var uuid = Uuid();
    Transaction newTransaction = Transaction(
      id: uuid.v1(),
      title: title,
      amount: amount,
      executionDate: executionDate,
      createAt: now,
      updatedAt: now,
    );
    _transactions.add(newTransaction);
  }

  void updateTransaction(int index, String title, double amount, DateTime executionDate) {
    DateTime now = DateTime.now();
    Transaction updatingTransaction = _transactions[index];
    updatingTransaction.title = title;
    updatingTransaction.amount = amount;
    updatingTransaction.executionDate = executionDate;
    updatingTransaction.updatedAt = now;
  }
}
