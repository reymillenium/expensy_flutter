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
import 'package:native_device_orientation/native_device_orientation.dart';

// Screens:
import 'package:expensy_flutter/screens/new_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';
import 'package:expensy_flutter/models/app_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';
import 'package:expensy_flutter/components/transaction_chart_bar_home_made.dart';

// Helpers:
import 'package:expensy_flutter/helpers/numeric_helper.dart';
import 'package:expensy_flutter/helpers/device_helper.dart';

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';

class TransactionsChartHomeMade extends StatelessWidget {
  // Properties:
  final List<Map> groupedAmountLastWeek;
  final double biggestAmountLastWeek;
  final NativeDeviceOrientation orientation;

  // Constructor:
  TransactionsChartHomeMade({
    this.groupedAmountLastWeek,
    this.biggestAmountLastWeek,
    this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    // AppData appData = Provider.of<AppData>(context, listen: true);
    // bool isLandscape = DeviceHelper.isLandscape(orientation);
    bool isPortrait = DeviceHelper.isPortrait(orientation);

    List<Widget> getColumns() {
      return List.from(groupedAmountLastWeek.reversed).map((groupedAmountOnDay) {
        return TransactionChartBarHomeMade(
          groupedAmountOnDay: groupedAmountOnDay,
          biggestAmountLastWeek: biggestAmountLastWeek,
          orientation: orientation,
        );
      }).toList();
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 3,
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          // side: BorderSide(color: Colors.red, width: 1),
          // borderRadius: BorderRadius.circular(10),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  if (isPortrait) ...[
                    Text(
                      'Last Week Transactions',
                      style: TextStyle(
                        // color: const Color(0xff379982),
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getColumns(),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
