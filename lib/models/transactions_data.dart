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

  get lastWeekTransactions {
    final DateTime now = DateTime.now();
    return _transactions.where((transaction) {
      int daysAgo = now.difference(transaction.executionDate).inDays;
      return daysAgo <= 6;
    }).toList();
  }

  // Private methods:
  void _generateDummyData() {
    final DateTime now = DateTime.now();
    final uuid = Uuid();

    // transactions = List<Transaction>.generate(20, (index) {
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

    for (int i = 0; i < 20; i++) {
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

  void _removeTransactionWhere(String id) {
    _transactions.removeWhere((element) => element.id == id);
  }

  Future<void> _showDialogPlus(String id, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // The user must tap the buttons!
      // barrierColor: Colors.transparent, // The background color
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here

          content: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(12),
              // height: 100,
              child: Column(
                children: <Widget>[
                  Text(
                    'This action is irreversible.',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text('Would you like to confirm this message?'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Row(
                  children: [
                    Text('Confirm'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.delete),
                  ],
                ),
                onPressed: () {
                  deleteTransactionWithoutConfirm(id);
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Row(
                  children: [
                    Text('Cancel'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.cancel),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Alert createAlert({String id, BuildContext context, String message = ''}) {
    return Alert(
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
            _removeTransactionWhere(id);
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
    );
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

  void deleteTransactionWithConfirm(String id, BuildContext context) {
    // createAlert(id: id, context: context).show().then((value) {
    //   (context as Element).reassemble();
    // });

    _showDialogPlus(id, context).then((value) {
      (context as Element).reassemble();
    });
  }

  void deleteTransactionWithoutConfirm(String id) {
    _removeTransactionWhere(id);
  }

  List<Map> groupedAmountLastWeek() {
    List<double> lastWeekAmounts = this.lastWeekAmounts();

    return List.generate(7, (index) {
      return {
        'day': DateHelper.weekDayTimeAgo(days: index),
        'amount': lastWeekAmounts[index],
      };
    });
  }

  double biggestAmountLastWeek() {
    return NumericHelper.biggestDoubleFromList(lastWeekAmounts());
  }

  List<double> lastWeekAmounts() {
    final DateTime now = DateTime.now();
    List<double> result = [0, 0, 0, 0, 0, 0, 0];

    lastWeekTransactions.forEach((transaction) {
      int daysAgo = now.difference(transaction.executionDate).inDays;
      result[daysAgo] += transaction.amount;
    });

    return NumericHelper.roundDoubles(result, 2);
  }
}
