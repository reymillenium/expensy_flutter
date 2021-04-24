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

  // Constructor:
  TransactionsList({this.transactions});

  List<TransactionsTile> getTransactionList2() {
    return transactions.map((transaction) {
      return TransactionsTile(transaction: transaction);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getTransactionList2(),
    );
  }
}
