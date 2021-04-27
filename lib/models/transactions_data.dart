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

// Utilities:

class TransactionsData {
  // Properties:
  List<Transaction> _transactions = [];

  // Constructor:
  TransactionsData() {
    generateDummyData();
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
    return (Random().nextDouble() * (max - min)) + min;
  }

  int _randomIntegerInRange({int min = 0, int max = 1}) {
    return Random().nextInt(max - min + 1) + min;
  }

  double _roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  // Private methods:
  void generateDummyData() {
    final DateTime now = DateTime.now();
    final uuid = Uuid();

    // transactions = List<Transaction>.generate(5, (index) {
    //   var uuid = Uuid();
    //   DateTime onTheLastWeek = now.subtract(new Duration(days: _randomIntegerInRange(min: 0, max: 6)));
    //
    //   return Transaction(
    //     id: '${uuid.v4()}',
    //     title: faker.food.dish(),
    //     amount: _roundDouble(_randomDoubleInRange(min: 0.99, max: 10.00), 2),
    //     executionDate: onTheLastWeek,
    //     createAt: now,
    //     updatedAt: now,
    //   );
    // });

    for (int i = 0; i < 40; i++) {
      DateTime onTheLastWeek = now.subtract(new Duration(days: _randomIntegerInRange(min: 0, max: 6)));

      Transaction newTransaction = Transaction(
        id: '${uuid.v4()}',
        title: faker.food.dish(),
        amount: _roundDouble(_randomDoubleInRange(min: 0.99, max: 10.00), 2),
        executionDate: onTheLastWeek,
        createAt: now,
        updatedAt: now,
      );
      _transactions.add(newTransaction);
      // print(_randomDoubleInRange(min: 9.97, max: 9.99));
      print(newTransaction.amount);
    }
  }

  void _removeTransaction(int index) {
    _transactions.removeAt(index);
  }

  void _showDialog(int index, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Removal Alert"),
          content: new Text("Are you sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                _removeTransaction(index);
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Alert _createAlert({int index, BuildContext context, String message = ''}) {
    return (Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure?",
      // desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _removeTransaction(index);
            Navigator.of(context).pop();
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ));
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

  void deleteTransactionWithConfirm(int index, BuildContext context) {
    // _showDialog(index, context);
    // _createAlert(index: index, context: context).show();
    _createAlert(index: index, context: context).show().then((value) {
      (context as Element).reassemble();
    });
  }

  void deleteTransactionWithoutConfirm(int index) {
    _removeTransaction(index);
  }

  List<double> groupedAmountLastWeek() {
    List<double> result = [0, 0, 0, 0, 0, 0, 0];
    final DateTime now = DateTime.now();

    for (int i = 0; i < _transactions.length; i++) {
      int daysAgo = now.difference(_transactions[i].executionDate).inDays;
      result[daysAgo] += _transactions[i].amount;
    }

    for (int j = 0; j < result.length; j++) {
      result[j] = _roundDouble(result[j], 2);
    }

    return result;
  }
}
