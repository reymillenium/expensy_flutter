// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:

// Utilities:

class TransactionsScreen extends StatefulWidget {
  // Properties
  final String title;

  // Constructor:
  TransactionsScreen({Key key, this.title}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // Properties:
  final TransactionsData transactionsData = TransactionsData();

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
            padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
            width: double.infinity,
            child: Card(
              elevation: 3,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                // side: BorderSide(color: Colors.red, width: 1),
                // borderRadius: BorderRadius.circular(10),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  child: Text(
                    'Transactions Chart',
                    style: TextStyle(
                        // color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),

          // Transaction List:
          Expanded(
            child: Container(
              child: TransactionsList(
                transactions: transactionsData.transactions,
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
