// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:

// Helpers:

// Utilities:

class ExpensesScreen extends StatefulWidget {
  // Properties
  final String title;

  // Constructor:
  ExpensesScreen({Key key, this.title}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // Properties:
  final List<Transaction> transactions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();

    // transactions = List<Transaction>.generate(5, (index) {
    //   return Transaction(
    //     id: 't$index',
    //     title: getRandomString(6),
    //     amount: randomDoubleInRange(min: 1.0, max: 100.0),
    //     createAt: now,
    //     updatedAt: now,
    //   );
    // });

    for (int i = 0; i < 5; i++) {
      Transaction newTransaction = Transaction(
        id: 't$i',
        title: getRandomString(6),
        // amount: randomDoubleInRange(min: 1.0, max: 100.0),
        amount: roundDouble(randomDoubleInRange(min: 1.0, max: 99.0), 2),
        createAt: now,
        updatedAt: now,
      );
      transactions.add(newTransaction);
    }
  }

  String getRandomString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  double randomDoubleInRange({double min = 0.0, double max = 1.0}) {
    return Random().nextDouble() * (max - min + 1) + min;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  List<ListTile> getTransactionList() {
    return transactions.map((transaction) {
      return ListTile(
        key: Key(transaction.id),
        leading: Text('${transaction.amount.toString()} USD'),
        title: Text(transaction.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'CHART',
                style: TextStyle(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),

          // Transaction List:
          Expanded(
            child: Container(
              child: ListView(
                children: getTransactionList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
