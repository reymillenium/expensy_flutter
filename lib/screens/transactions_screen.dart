// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transactions_chart.dart';

// Helpers:

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';

class TransactionsScreen extends StatefulWidget {
  // Properties:
  final String title;

  // Constructor:
  TransactionsScreen({Key key, this.title}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // State Properties:
  final TransactionsData transactionsData = TransactionsData();
  int touchedIndex;

  void _onAddTransactionHandler(String title, double amount, DateTime executionDate) {
    setState(() {
      transactionsData.addTransaction(title, amount, executionDate);
    });
  }

  void _onUpdateTransactionHandler(int index, String title, double amount, DateTime executionDate) {
    setState(() {
      transactionsData.updateTransaction(index, title, amount, executionDate);
    });
  }

  void _onDeleteTransactionHandler(int index) {
    setState(() {
      transactionsData.deleteTransactionWithConfirm(index, context);
    });
  }

  void _touchCallbackHandler(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null && barTouchResponse.touchInput is! PointerUpEvent && barTouchResponse.touchInput is! PointerExitEvent) {
        touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
      } else {
        touchedIndex = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.add_rounded),
            tooltip: 'Add Transaction',
            onPressed: () => _showModalNewTransaction(context),
          ),
        ],
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Preferences...'),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Transactions Bar Chart
          TransactionsChart(
            touchCallbackHandler: _touchCallbackHandler,
            touchedIndex: touchedIndex,
            groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
            biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
          ),

          // Transaction List:
          Expanded(
            flex: 5,
            child: TransactionsList(
              transactions: transactionsData.transactions,
              onUpdateTransactionHandler: _onUpdateTransactionHandler,
              onDeleteTransactionHandler: _onDeleteTransactionHandler,
            ),
          ),
        ],
      ),

      // Navigation Bar (without nav links)
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(null), onPressed: () {}),
            // Spacer(),
            // IconButton(icon: Icon(Icons.search), onPressed: () {}),
            // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.purple,
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
        onPressed: () => _showModalNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // It shows the AddTransactionScreen widget as a modal:
  void _showModalNewTransaction(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewTransactionScreen(
        onAddTransactionHandler: _onAddTransactionHandler,
      ),
    );
  }
}
