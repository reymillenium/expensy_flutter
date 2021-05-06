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

// Helpers:
import 'package:expensy_flutter/helpers/sound_helper.dart';

// Utilities:
import 'package:tinycolor/tinycolor.dart';
import 'package:expensy_flutter/utilities/constants.dart';

class ExpensyAppBar extends StatelessWidget with PreferredSizeWidget {
  // Properties:
  final String title;
  final Function showModalNewTransaction;

  const ExpensyAppBar({
    Key key,
    this.title,
    this.showModalNewTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentThemeFont = appData.currentThemeFont;

    return AppBar(
      title: Text(
        title,
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
          // onPressed: () => showModalNewTransaction(context),
          onPressed: showModalNewTransaction,
        ),
      ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0),
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolBarHeight);
}
