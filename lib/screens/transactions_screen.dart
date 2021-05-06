// Packages:
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transactions_chart.dart';
import 'package:expensy_flutter/components/expensy_drawer.dart';

// Helpers:
import 'package:expensy_flutter/helpers/sound_helper.dart';

// Utilities:
import 'package:tinycolor/tinycolor.dart';

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

  void _onDeleteTransactionHandler(String id) async {
    // setState(() {
    transactionsData.deleteTransactionWithConfirm(id, this.context);
    // });
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
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentThemeFont = appData.currentThemeFont;
    // Drawer related:
    Function closeAllThePanels = appData.closeAllThePanels;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          // style: TextStyle(
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          //   fontFamily: currentThemeFont['fontFamily'],
          // ),
          style: Theme.of(context).appBarTheme.textTheme.headline6.copyWith(
                fontFamily: currentThemeFont['fontFamily'],
              ),
        ),
        actions: [
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.add_rounded),
            tooltip: 'Add Transaction',
            onPressed: () => _showModalNewTransaction(context),
          ),
        ],
      ),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          closeAllThePanels();
        }
      },

      drawer: ExpensyDrawer(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Transactions Bar Chart
          Expanded(
            flex: 3,
            child: TransactionsChart(
              touchCallbackHandler: _touchCallbackHandler,
              touchedIndex: touchedIndex,
              groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
              biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
              // primaryColor: Theme.of(context).primaryColor,
            ),
          ),

          // Home Made Transactions Bar Chart
          // TransactionsChartHomeMade(
          //   groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
          //   biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
          // ),

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
        color: Theme.of(context).primaryColor,
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
    SoundHelper().playSmallButtonClick();
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
