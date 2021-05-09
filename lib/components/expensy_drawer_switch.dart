// Packages:
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transactions_chart.dart';
import 'package:expensy_flutter/components/expensy_drawer_switch.dart';

// Helpers:

// Utilities:
import 'package:tinycolor/tinycolor.dart';

class ExpensyDrawerSwitch extends StatelessWidget {
  const ExpensyDrawerSwitch({
    Key key,
    @required this.switchLabel,
    @required this.primaryColor,
    @required this.showChart,
    @required this.onToggle,
  }) : super(key: key);

  final String switchLabel;
  final Color primaryColor;
  final bool showChart;
  final Function onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: SizedBox(
        // width: 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              switchLabel,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              width: 20,
            ),
            FlutterSwitch(
              showOnOff: true,
              activeColor: primaryColor,
              activeTextColor: Colors.black,
              inactiveTextColor: Colors.blue[50],
              width: 55.0,
              height: 25.0,
              valueFontSize: 12.0,
              toggleSize: 18.0,
              value: showChart,
              onToggle: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}
