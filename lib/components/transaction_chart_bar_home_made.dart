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

class TransactionChartBarHomeMade extends StatelessWidget {
  // Properties:
  final Map groupedAmountOnDay;
  final double biggestAmountLastWeek;

  // Constructor:
  TransactionChartBarHomeMade({
    this.groupedAmountOnDay,
    this.biggestAmountLastWeek,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const backgroundColumnHeight = 120.0;
    double activeBarHeight = groupedAmountOnDay['amount'] == 0 ? 0 : NumericHelper.roundDouble((groupedAmountOnDay['amount'] / biggestAmountLastWeek) * (backgroundColumnHeight - 10), 2);

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 20,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text('${NumericHelper.roundDouble(groupedAmountOnDay['amount'], 2)}'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Container(
              height: backgroundColumnHeight,
              width: 20,
              decoration: BoxDecoration(
                color: TinyColor(primaryColor).lighten(16).color,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: activeBarHeight,
              width: 20,
              decoration: BoxDecoration(
                // color: Theme.of(context).accentColor,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          groupedAmountOnDay['day'].substring(0, 2),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
    ;
  }
}