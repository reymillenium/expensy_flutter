// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:
import 'package:expensy_flutter/components/transaction_tile.dart';

// Helpers:

// Utilities:

class TransactionsList extends StatelessWidget {
  // Properties:
  final List<Transaction> transactions;
  final _listViewScrollController = ScrollController();

  // Constructor:
  TransactionsList({this.transactions});

  List<TransactionTile> getTransactionList2() {
    return transactions.map((transaction) {
      return TransactionTile(transaction: transaction);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   padding: const EdgeInsets.only(left: 0, top: 20, right: 0),
    //   children: getTransactionList2(),
    // );

    return ListView.builder(
      padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
      controller: _listViewScrollController,
      itemBuilder: (context, index) {
        return TransactionTile(
          transaction: transactions[index],
        );
      },
      itemCount: transactions.length,
    );
  }
}
