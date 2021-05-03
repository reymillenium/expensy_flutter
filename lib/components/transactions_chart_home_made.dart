// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent
import 'package:tinycolor/tinycolor.dart'; // Allows to light a color and many other things
import 'package:provider/provider.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:
import 'package:expensy_flutter/helpers/numeric_helper.dart';

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';

class TransactionsChartHomeMade extends StatelessWidget {
  // Properties:
  final List<Map> groupedAmountLastWeek;

  // Constructor:
  TransactionsChartHomeMade({
    this.groupedAmountLastWeek,
  });

  @override
  Widget build(BuildContext context) {
    // AppData appData = Provider.of<AppData>(context, listen: true);

    List<Widget> getColumns() {
      return List.from(groupedAmountLastWeek.reversed).map((e) {
        return Column(
          children: [
            Text(
              e['day'].substring(0, 2),
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text('${NumericHelper.roundDouble(e['amount'], 2)}'),
          ],
        );
      }).toList();
    }

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: getColumns(),
      ),
    );
  }
}
