// Packages:
import 'package:expensy_flutter/components/expensy_app_bar.dart';
import 'package:expensy_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/services.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transactions_chart.dart';
import 'package:expensy_flutter/components/expensy_drawer.dart';
import 'package:expensy_flutter/components/transactions_chart_home_made.dart';

// Helpers:
import 'package:expensy_flutter/helpers/sound_helper.dart';
import 'package:expensy_flutter/helpers/device_helper.dart';
import 'package:expensy_flutter/helpers/db_helper.dart';

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
  DBHelper dbHelper;
  TransactionsData transactionsData = TransactionsData();
  int touchedIndex;
  bool _showChart = false;
  bool _showPortraitOnly = false;

  void _onAddTransactionHandler(String title, double amount, DateTime executionDate) {
    setState(() {
      transactionsData.addTransaction(title, amount, executionDate);
    });
  }

  void _onUpdateTransactionHandler(int id, String title, double amount, DateTime executionDate) {
    setState(() {
      transactionsData.updateTransaction(id, title, amount, executionDate);
    });
  }

  void _onDeleteTransactionHandler(int id) async {
    setState(() {
      transactionsData.deleteTransactionWithConfirm(id, this.context);
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

  void onSwitchShowChart(bool choice) {
    setState(() {
      _showChart = choice;
    });
  }

  void onSwitchPortraitOnLy(bool choice) {
    setState(() {
      _showPortraitOnly = choice;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    refreshData();
    // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    //   if (!_showPortraitOnly) ...[
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ],
    // ]);
  }

  void refreshData() {
    dbHelper.getMonetaryTransactions().then((transactions) {
      for (MonetaryTransaction temp in transactions) {
        // if (temp.type == "student") data.add(temp);
        // transactionsData.addOneSingleTransaction(temp);
      }
      // since you have already added the results to data
      // setState can have an empty function body
      setState(() {});
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:

    ExpensyAppBar appBar = ExpensyAppBar(
      title: widget.title,
      showModalNewTransaction: () => _showModalNewTransaction(context),
    );

    double appBarHeight = appBar.preferredSize.height;
    // print('totalVerticalHeight: ${DeviceHelper.totalVerticalHeight(context: context)}');
    // print('statusBarTopPadding: ${DeviceHelper.statusBarTopPadding(context: context)}');
    // print('appBarHeight: $appBarHeight');
    // print('availableHeight: ${DeviceHelper.availableHeight(context: context, appBarHeight: appBarHeight)}');

    // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      if (!_showPortraitOnly) ...[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    ]);

    return Scaffold(
      appBar: appBar,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          closeAllThePanels();
        }
      },

      drawer: ExpensyDrawer(
        showChart: _showChart,
        // showPortraitOnly: _showPortraitOnly,
        onSwitchShowChart: onSwitchShowChart,
        // onSwitchPortraitOnLy: onSwitchPortraitOnLy,
      ),

      body: NativeDeviceOrientationReader(
        builder: (context) {
          final orientation = NativeDeviceOrientationReader.orientation(context);
          // print('Received new orientation: $orientation');
          bool safeAreaLeft = orientation == NativeDeviceOrientation.landscapeLeft ? true : false;
          bool safeAreaRight = orientation == NativeDeviceOrientation.landscapeRight ? true : false;
          bool isLandscape = DeviceHelper.isLandscape(orientation);
          bool isPortrait = DeviceHelper.isPortrait(orientation);
          return SafeArea(
            left: safeAreaLeft,
            right: safeAreaRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_showChart) ...[
                  // Transactions Bar Chart
                  Expanded(
                    flex: isLandscape ? 4 : 3,
                    // flex: 4,
                    child: TransactionsChart(
                      touchCallbackHandler: _touchCallbackHandler,
                      touchedIndex: touchedIndex,
                      groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
                      biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
                      orientation: orientation,
                    ),
                  ),

                  // Home Made Transactions Bar Chart
                  // Expanded(
                  //   flex: isLandscape ? 4 : 3,
                  //   child: TransactionsChartHomeMade(
                  //     groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
                  //     biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
                  //     orientation: orientation,
                  //   ),
                  // ),
                ],

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
          );
        },
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
