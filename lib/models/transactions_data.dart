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
import 'package:expensy_flutter/helpers/date_helper.dart';

// Utilities:

class TransactionsData {
  // Properties:
  List<Transaction> _transactions = [];

  // Constructor:
  TransactionsData() {
    _generateDummyData();
  }

  // Getters:
  get transactions {
    return _transactions;
  }

  // Private methods:
  void _generateDummyData() {
    final DateTime now = DateTime.now();
    final uuid = Uuid();

    // transactions = List<Transaction>.generate(40, (index) {
    //   var uuid = Uuid();
    //   DateTime onTheLastWeek = now.subtract(new Duration(days: NumericHelper.randomIntegerInRange(min: 0, max: 6)));
    //
    //   return Transaction(
    //     id: '${uuid.v4()}',
    //     title: faker.food.dish(),
    //     amount: NumericHelper.roundDouble(NumericHelper.randomDoubleInRange(min: 0.99, max: 10.00), 2),
    //     executionDate: onTheLastWeek,
    //     createAt: now,
    //     updatedAt: now,
    //   );
    // });

    for (int i = 0; i < 40; i++) {
      DateTime onTheLastWeek = DateHelper.randomDateTimeOnTheLastWeek();

      Transaction newTransaction = Transaction(
        id: '${uuid.v4()}',
        title: faker.food.dish(),
        amount: NumericHelper.roundRandomDoubleInRange(min: 0.99, max: 10.00, places: 2),
        executionDate: onTheLastWeek,
        createAt: now,
        updatedAt: now,
      );
      _transactions.add(newTransaction);
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

  List<Map> groupedAmountLastWeek() {
    List<Map> result = [
      {
        'day': DateHelper.weekDayNow(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDayOneDayAgo(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDayTwoDaysAgo(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDayThreeDaysAgo(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDayFourDaysAgo(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDayFiveDaysAgo(),
        'amount': 0,
      },
      {
        'day': DateHelper.weekDaySixDaysAgo(),
        'amount': 0,
      }
    ];

    List<double> lastWeekAmounts = this.lastWeekAmounts();
    for (int i = 0; i < lastWeekAmounts.length; i++) {
      result[i]['amount'] += lastWeekAmounts[i];
    }

    // print(result);
    return result;
  }

  double biggestAmountLastWeek() {
    return NumericHelper.biggestDoubleFromList(lastWeekAmounts());
  }

  List<double> lastWeekAmounts() {
    final DateTime now = DateTime.now();
    List<double> result = [0, 0, 0, 0, 0, 0, 0];

    for (int i = 0; i < _transactions.length; i++) {
      int daysAgo = now.difference(_transactions[i].executionDate).inDays;
      if (daysAgo <= 6) {
        result[daysAgo] += _transactions[i].amount;
      }
    }

    for (int j = 0; j < result.length; j++) {
      result[j] = NumericHelper.roundDouble(result[j], 2);
    }

    return result;
  }
}
