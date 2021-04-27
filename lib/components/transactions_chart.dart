// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fl_chart/fl_chart.dart'; // Allows to use the Bar Charts
import 'package:flutter/gestures.dart'; // Allows: PointerExitEvent

// Screens:
import 'package:expensy_flutter/screens/add_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:

// Utilities:

class TransactionsChart extends StatelessWidget {
  // Properties:
  final Function touchCallbackHandler;
  final int touchedIndex;
  final List<double> groupedAmountLastWeek;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  // bool isPlaying = false;

  // Constructor:
  TransactionsChart({
    this.touchCallbackHandler,
    this.touchedIndex,
    this.groupedAmountLastWeek,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Weekly',
                    style: TextStyle(
                      color: const Color(0xff0f4a3c),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Transactions Chart',
                    style: TextStyle(color: const Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: groupedAmountLastWeek.reduce(max) + 2,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            // return makeGroupData(0, 5, isTouched: i == touchedIndex);
            return makeGroupData(0, groupedAmountLastWeek[0], isTouched: i == touchedIndex);
          case 1:
            // return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
            return makeGroupData(1, groupedAmountLastWeek[1], isTouched: i == touchedIndex);
          case 2:
            // return makeGroupData(2, 5, isTouched: i == touchedIndex);
            return makeGroupData(2, groupedAmountLastWeek[2], isTouched: i == touchedIndex);
          case 3:
            // return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
            return makeGroupData(3, groupedAmountLastWeek[3], isTouched: i == touchedIndex);
          case 4:
            // return makeGroupData(4, 9, isTouched: i == touchedIndex);
            return makeGroupData(4, groupedAmountLastWeek[4], isTouched: i == touchedIndex);
          case 5:
            // return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
            return makeGroupData(5, groupedAmountLastWeek[5], isTouched: i == touchedIndex);
          case 6:
            // return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
            return makeGroupData(6, groupedAmountLastWeek[6], isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        // touchCallback: (barTouchResponse) {
        //   setState(() {
        //     if (barTouchResponse.spot != null && barTouchResponse.touchInput is! PointerUpEvent && barTouchResponse.touchInput is! PointerExitEvent) {
        //       touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
        //     } else {
        //       touchedIndex = -1;
        //     }
        //   });
        // },
        touchCallback: (barTouchResponse) => touchCallbackHandler(barTouchResponse),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
