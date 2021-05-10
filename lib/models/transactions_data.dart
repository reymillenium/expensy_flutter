// Packages:

import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:

// Helpers:
import 'package:expensy_flutter/helpers/_helpers.dart';

// Utilities:

class TransactionsData {
  // Properties:
  List<MonetaryTransaction> _transactions = [];
  DBHelper dbHelper;

  // Constructor:
  TransactionsData() {
    dbHelper = DBHelper();
    refreshTransactionList();
    // _generateDummyData();
  }

  // Getters:
  get transactions {
    // refreshTransactionList();
    return _transactions;
  }

  // Future<List<MonetaryTransaction>> getMonetaryTransactions() async {
  //   return await dbHelper.getMonetaryTransactions();
  // }

  get lastWeekTransactions {
    final DateTime now = DateTime.now();
    return _transactions.where((transaction) {
      int daysAgo = now.difference(transaction.executionDate).inDays;
      return (daysAgo <= 6 && daysAgo >= 0);
    }).toList();
  }

  // void addOneSingleTransaction(MonetaryTransaction monetaryTransaction) {
  //   _transactions.add(monetaryTransaction);
  // }

  // Private methods:
  void _generateDummyData() async {
    // final DateTime now = DateTime.now();
    // final uuid = Uuid();

    // transactions = List<Transaction>.generate(20, (index) {
    //   var uuid = Uuid();
    //   DateTime onTheLastWeek = now.subtract(new Duration(days: NumericHelper.randomIntegerInRange(min: 0, max: 6)));
    //
    //   return Transaction(
    //     id: '${uuid.v4()}',
    //     title: faker.food.dish(),
    //     amount: NumericHelper.roundDouble(NumericHelper.randomDoubleInRange(min: 0.99, max: 10.00), 2),
    //     executionDate: onTheLastWeek,
    //     createdAt: now,
    //     updatedAt: now,
    //   );
    // });

    // for (int i = 0; i < 20; i++) {
    //   DateTime onTheLastWeek = DateHelper.randomDateTimeOnTheLastWeek();
    //
    //   MonetaryTransaction newTransaction = MonetaryTransaction(
    //     // id: '${uuid.v4()}',
    //     title: faker.food.dish(),
    //     amount: NumericHelper.roundRandomDoubleInRange(min: 0.99, max: 10.00, places: 2),
    //     executionDate: onTheLastWeek,
    //     createdAt: now,
    //     updatedAt: now,
    //   );
    //   _transactions.add(newTransaction);
    // }

    // List<MonetaryTransaction> monetaryTransactions = await dbHelper.getMonetaryTransactions();
    // for (int i = 0; i < monetaryTransactions.length; i++) {
    //   MonetaryTransaction newTransaction = monetaryTransactions[i];
    //   // print(newTransaction.title);
    //   _transactions.add(newTransaction);
    // }
  }

  void _removeTransactionWhere(int id) async {
    // _transactions.removeWhere((element) => element.id == id);

    await dbHelper.deleteTransaction(id);
    await refreshTransactionList();
  }

  Future refreshTransactionList() async {
    _transactions = await dbHelper.getMonetaryTransactions();
    // dbHelper.getMonetaryTransactions().then((result) {
    //   _transactions = result;
    // });
  }

  Future<void> _showDialogPlus(int id, BuildContext context) async {
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

  Alert createAlert({int id, BuildContext context, String message = ''}) {
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
  Future<void> addTransaction(String title, double amount, DateTime executionDate) async {
    DateTime now = DateTime.now();
    var uuid = Uuid();
    MonetaryTransaction newTransaction = MonetaryTransaction(
      // id: uuid.v1(),
      title: title,
      amount: amount,
      executionDate: executionDate,
      createdAt: now,
      updatedAt: now,
    );
    // _transactions.add(newTransaction);

    await dbHelper.saveTransaction(newTransaction);
    refreshTransactionList();
  }

  Future<void> updateTransaction(int id, String title, double amount, DateTime executionDate) async {
    DateTime now = DateTime.now();
    // MonetaryTransaction updatingTransaction = _transactions[index];
    MonetaryTransaction updatingTransaction = _transactions.firstWhere((transaction) => id == transaction.id);

    updatingTransaction.title = title;
    updatingTransaction.amount = amount;
    updatingTransaction.executionDate = executionDate;
    updatingTransaction.updatedAt = now;

    await dbHelper.updateTransaction(updatingTransaction);
    refreshTransactionList();
  }

  Future<void> deleteTransactionWithConfirm(int id, BuildContext context) {
    // createAlert(id: id, context: context).show().then((value) {
    //   (context as Element).reassemble();
    // });

    _showDialogPlus(id, context).then((value) {
      (context as Element).reassemble();
      refreshTransactionList();
    });
  }

  void deleteTransactionWithoutConfirm(int id) {
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
