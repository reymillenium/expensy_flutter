// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transactions_chart.dart';
import 'package:expensy_flutter/components/multi_platform_select_box.dart';

// Helpers:
import 'package:expensy_flutter/helpers/sound_helper.dart';

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';
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
  List<Map> expansionPanelListStatus = [
    {'isOpened': false},
    {'isOpened': false},
    {'isOpened': false},
  ];

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
    AppData appData = Provider.of<AppData>(context, listen: true);
    List<Map> availableThemeColors = appData.availableThemeColors;
    Map currentThemeColors = appData.currentThemeColors;
    List<Map> availableThemeFonts = appData.availableThemeFonts;
    Map currentThemeFont = appData.currentThemeFont;
    List<Map> availableCurrencies = appData.availableCurrencies;
    Map currentCurrency = appData.currentCurrency;

    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    Function setCurrentThemeColorHandler = (themeColorIndex) => appData.setCurrentThemeColor(themeColorIndex);
    Function setCurrentFontFamilyHandler = (themeFontIndex) => appData.setCurrentFontFamily(themeFontIndex);
    Function setCurrentCurrencyHandler = (currencyIndex) => appData.setCurrentCurrency(currencyIndex);

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
          _closeAllThePanels();
        }
      },

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, accentColor],
                  // colors: [Colors.purple, Colors.purpleAccent],
                ),
              ),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/expensy_logo.png",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Expensy',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: currentThemeFont['fontFamily'],
                    ),
                  ),
                  // Text('Primary Color:'),
                ],
              ),
            ),
            // ExpansionTile(
            //   leading: Icon(
            //     Icons.palette,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Theme color:',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   children: availableThemeColors.asMap().entries.map((entry) {
            //     int index = entry.key;
            //     Map value = entry.value;
            //
            //     return ListTile(
            //       title: Text(
            //         value['name'],
            //         style: TextStyle(
            //           color: value['theme']['primaryColor'],
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       onTap: () {
            //         // Update the state of the app.
            //         setCurrentThemeColorHandler(index);
            //         // Then close the drawer
            //         Navigator.pop(context);
            //       },
            //     );
            //   }).toList(),
            // ),
            // ExpansionTile(
            //   leading: FaIcon(
            //     FontAwesomeIcons.font,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Theme font:',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   children: availableThemeFonts.asMap().entries.map((entry) {
            //     int index = entry.key;
            //     Map value = entry.value;
            //
            //     return ListTile(
            //       title: Text(
            //         value['name'],
            //         style: TextStyle(
            //           fontFamily: value['fontFamily'],
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       onTap: () {
            //         // Update the state of the app.
            //         setCurrentFontFamilyHandler(index);
            //         // Then close the drawer
            //         Navigator.pop(context);
            //       },
            //     );
            //   }).toList(),
            // ),
            ExpansionPanelList(
              expansionCallback: _openOnePanelAndCloseTheRest,
              children: [
                // Expansion Panel # 1: Theme colors
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(
                        Icons.palette,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Theme color:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: availableThemeColors.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map value = entry.value;
                      // Each Theme Color List Tile:
                      return ListTile(
                        title: Text(
                          value['name'],
                          style: TextStyle(
                            color: value['theme']['primaryColor'],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setCurrentThemeColorHandler(index);
                          // closeAllThePanels();
                          // Navigator.pop(context);
                        },
                        tileColor: _activeTileColor(currentThemeColors['name'], value['name']),
                      );
                    }).toList(),
                  ),
                  isExpanded: expansionPanelListStatus[0]['isOpened'],
                ),

                // Expansion Panel # 2: Theme fonts
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.font,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Theme font:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: availableThemeFonts.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map value = entry.value;
                      // Each Theme Color List Tile:
                      return ListTile(
                        title: Text(
                          value['name'],
                          style: TextStyle(
                            fontFamily: value['fontFamily'],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setCurrentFontFamilyHandler(index);
                          // closeAllThePanels();
                          // Navigator.pop(context);
                        },
                        tileColor: _activeTileColor(currentThemeFont['name'], value['name']),
                      );
                    }).toList(),
                  ),
                  isExpanded: expansionPanelListStatus[1]['isOpened'],
                ),

                // Expansion Panel # 3: Currencies
                ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.moneyBill,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Currency:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: availableCurrencies.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map value = entry.value;
                      // Each Currency List Tile:
                      return ListTile(
                        leading: FaIcon(
                          value['icon'],
                          color: Colors.black,
                        ),
                        title: Text(
                          value['name'],
                          style: TextStyle(
                            fontFamily: currentThemeFont['fontFamily'],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setCurrentCurrencyHandler(index);
                          // closeAllThePanels();
                          // Navigator.pop(context);
                        },
                        tileColor: _activeTileColor(currentCurrency['code'], value['code']),
                      );
                    }).toList(),
                  ),
                  isExpanded: expansionPanelListStatus[2]['isOpened'],
                ),
              ],
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
            // groupedAmountLastWeek: transactionsData.groupedAmountLastWeek(),
            groupedAmountLastWeek: transactionsData.groupedAmountLastWeek2(),
            biggestAmountLastWeek: transactionsData.biggestAmountLastWeek(),
            // primaryColor: Theme.of(context).primaryColor,
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

  void _closeAllThePanels() {
    setState(() {
      for (int i = 0; i < expansionPanelListStatus.length; i++) {
        expansionPanelListStatus[i]['isOpened'] = false;
      }
    });
  }

  void _openOnePanelAndCloseTheRest(int index, bool isExpanded) {
    setState(() {
      for (int i = 0; i < expansionPanelListStatus.length; i++) {
        if (index == i) {
          expansionPanelListStatus[index]['isOpened'] = !isExpanded;
        } else {
          expansionPanelListStatus[i]['isOpened'] = false;
        }
      }
    });
  }

  Color _activeTileColor(String currentValue, String valueToCompare) {
    return currentValue == valueToCompare ? TinyColor(Colors.black54).lighten(60).color : Colors.transparent;
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
