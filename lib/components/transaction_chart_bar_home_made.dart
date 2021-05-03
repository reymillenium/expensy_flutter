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

  // Constructor:
  TransactionChartBarHomeMade({
    this.groupedAmountOnDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          groupedAmountOnDay['day'].substring(0, 2),
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        Text('${NumericHelper.roundDouble(groupedAmountOnDay['amount'], 2)}'),
      ],
    );
    ;
  }
}
