// Packages:
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat
import 'package:date_time_picker/date_time_picker.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';
import 'package:expensy_flutter/models/transactions_data.dart';

// Components:
import 'package:expensy_flutter/components/transactions_list.dart';

// Helpers:

// Utilities:

class AddTransactionScreen extends StatelessWidget {
  // Properties:
  final Function onAddTransactionHandler;

  // Constructor:
  AddTransactionScreen({this.onAddTransactionHandler});

  @override
  Widget build(BuildContext context) {
    String title = '';
    double amount = 0;
    DateTime now = DateTime.now();
    final oneHundredYearsAgo = now.subtract(new Duration(days: 365 * 100));
    final oneHundredYearsFromNow = now.add(new Duration(days: 365 * 100));
    DateTime executionDate = now;

    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                ),
              ),

              // Title Input
              TextField(
                autofocus: true,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: kLightBlueBackground,
                      color: Colors.red,
                      // width: 30,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 4.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purpleAccent,
                      // color: Colors.red,
                      width: 6.0,
                    ),
                  ),
                ),
                style: TextStyle(),
                onChanged: (String newText) {
                  // setState(() {
                  title = newText;
                  // });
                },
              ),

              // Amount Input
              TextField(
                decoration: InputDecoration(hintText: 'USD(\$) '),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    // turnOffGrouping: false,
                    locale: 'en_US',
                    decimalDigits: 2,
                    symbol: 'USD(\$) ', // or to remove symbol set ''.
                    // symbol: '', // or to remove symbol set ''.
                  )
                ],
                keyboardType: TextInputType.number,
                onChanged: (String newText) {
                  // amount = double.parse(newText);
                  // Allows only numbers:
                  // amount = newText == '' ? 0 : double.parse(newText.replaceAll(new RegExp(r'[^0-9]'), ''));
                  // Allows numbers and a dot
                  amount = newText == '' ? 0 : double.parse(newText.replaceAll(new RegExp(r'[^0-9\.]'), ''));
                },
              ),

              // DateTime picker
              DateTimePicker(
                // type: DateTimePickerType.dateTimeSeparate,
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: now.toString(),
                firstDate: oneHundredYearsAgo,
                lastDate: oneHundredYearsFromNow,
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  // if (date.weekday == 6 || date.weekday == 7) {
                  //   return false;
                  // }

                  return true;
                },
                onChanged: (val) {
                  print('onChanged $val');
                  executionDate = DateTime.parse(val);
                },
                validator: (val) {
                  print(val);
                  return null;
                },
                // onSaved: (val) => print(val),
              ),

              // Add button:
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Material(
                  color: Colors.purple,
                  // borderRadius: BorderRadius.circular(12.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      if (title != '' && amount != 0) {
                        onAddTransactionHandler(title, amount, executionDate);
                      }
                      Navigator.pop(context);
                    },
                    // minWidth: 300.0,
                    minWidth: double.infinity,
                    height: 42.0,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
