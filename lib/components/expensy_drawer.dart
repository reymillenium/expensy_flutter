// Packages:

import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/_components.dart';

// Helpers:

// Utilities:

class ExpensyDrawer extends StatelessWidget {
  // Properties:
  final bool showChart;
  // final bool showPortraitOnly;
  final Function onSwitchShowChart;
  // final Function onSwitchPortraitOnLy;

  // Constructor:
  ExpensyDrawer({
    Key key,
    this.showChart,
    // this.showPortraitOnly,
    this.onSwitchShowChart,
    // this.onSwitchPortraitOnLy,
  }) : super(key: key);

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

    List<Map> expansionPanelListStatus = appData.expansionPanelListStatus;
    Function openOnePanelAndCloseTheRest = appData.openOnePanelAndCloseTheRest;

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header:
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

          // Drawer options: (Expansion Panels)
          ExpansionPanelList(
            expansionCallback: openOnePanelAndCloseTheRest,
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
                      'Theme:',
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
                      tileColor: _getActiveTileColor(currentThemeColors['name'], value['name']),
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
                      'Font:',
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
                      tileColor: _getActiveTileColor(currentThemeFont['name'], value['name']),
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
                      tileColor: _getActiveTileColor(currentCurrency['code'], value['code']),
                    );
                  }).toList(),
                ),
                isExpanded: expansionPanelListStatus[2]['isOpened'],
              ),
            ],
          ),

          // Switchers:
          ExpensyDrawerSwitch(
            switchLabel: 'Show chart',
            primaryColor: primaryColor,
            showChart: showChart,
            onToggle: onSwitchShowChart,
          ),
          // ExpensyDrawerSwitch(
          //   switchLabel: 'Portrait only',
          //   primaryColor: primaryColor,
          //   showChart: showPortraitOnly,
          //   onToggle: onSwitchPortraitOnLy,
          // ),
        ],
      ),
    );
  }

  Color _getActiveTileColor(String currentValue, String valueToCompare) {
    return currentValue == valueToCompare ? TinyColor(Colors.black54).lighten(60).color : Colors.transparent;
  }
}
