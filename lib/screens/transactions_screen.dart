// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:
import 'package:expensy_flutter/components/_components.dart';

// Helpers:
import 'package:expensy_flutter/helpers/_helpers.dart';

// Utilities:

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
  int touchedIndex;
  bool _showChart = false;
  bool _showPortraitOnly = false;

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
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Function closeAllThePanels = appData.closeAllThePanels; // Drawer related:
    bool isWeeklyFlChart = appData.isWeeklyFlChart;
    bool deviceIsIOS = DeviceHelper.deviceIsIOS(context);

    // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      if (!_showPortraitOnly) ...[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    ]);

    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    Function _onAddTransactionHandler = (title, amount, executionDate) => transactionsData.addTransaction(title, amount, executionDate);
    Function _onUpdateTransactionHandler = (id, title, amount, executionDate) => transactionsData.updateTransaction(id, title, amount, executionDate);
    Function _onDeleteTransactionHandler = (id, context) => transactionsData.deleteTransactionWithConfirm(id, context);

    ExpensyAppBar appBar = ExpensyAppBar(
      title: widget.title,
      showModalNewTransaction: () => _showModalNewTransaction(context, _onAddTransactionHandler),
    );

    // double appBarHeight = appBar.preferredSize.height;
    // print('totalVerticalHeight: ${DeviceHelper.totalVerticalHeight(context: context)}');
    // print('statusBarTopPadding: ${DeviceHelper.statusBarTopPadding(context: context)}');
    // print('appBarHeight: $appBarHeight');
    // print('availableHeight: ${DeviceHelper.availableHeight(context: context, appBarHeight: appBarHeight)}');

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
          bool safeAreaLeft = DeviceHelper.isLandscapeLeft(orientation);
          bool safeAreaRight = DeviceHelper.isLandscapeRight(orientation);
          bool isLandscape = DeviceHelper.isLandscape(orientation);

          return SafeArea(
            left: safeAreaLeft,
            right: safeAreaRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_showChart) ...[
                  if (isWeeklyFlChart) ...[
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
                  ] else ...[
                    // Home Made Transactions Bar Chart
                    Expanded(
                      flex: isLandscape ? 4 : 3,
                      child: TransactionsChartHomeMade(
                        groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
                        biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
                        orientation: orientation,
                      ),
                    ),
                  ],
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
      floatingActionButton: deviceIsIOS
          ? null
          : FloatingActionButton(
              tooltip: 'Add Transaction',
              child: Icon(Icons.add),
              onPressed: () => _showModalNewTransaction(context, _onAddTransactionHandler),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonLocation: deviceIsIOS ? null : FloatingActionButtonLocation.endDocked,
    );
  }

  // It shows the AddTransactionScreen widget as a modal:
  void _showModalNewTransaction(BuildContext context, Function _onAddTransactionHandler) {
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
