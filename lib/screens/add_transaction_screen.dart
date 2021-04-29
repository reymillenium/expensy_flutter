// Packages:
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expensy_flutter/helpers/date_helper.dart';
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
import 'package:expensy_flutter/helpers/string_helper.dart';

// Utilities:

class AddTransactionScreen extends StatefulWidget {
  // Properties:
  final Function onAddTransactionHandler;

  // Constructor:
  AddTransactionScreen({this.onAddTransactionHandler});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  // State Properties:
  String title = '';
  double amount = 0;
  DateTime executionDate = DateTime.now();

  // Run time constants:
  final oneHundredYearsAgo = DateHelper.timeAgo(years: 100);
  final oneHundredYearsFromNow = DateHelper.timeFromNow(years: 100);

  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    title = newText;
                  });
                },
                onSubmitted: !hasValidData() ? null : (_) => submitData(),
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
                onChanged: (String newAmountText) {
                  setState(() {
                    amount = StringHelper.extractDoubleOrZero(newAmountText);
                  });
                },
                onSubmitted: !hasValidData() ? null : (_) => submitData(),
              ),

              // DateTime picker
              DateTimePicker(
                // type: DateTimePickerType.dateTimeSeparate,
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
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
                  setState(() {
                    executionDate = DateTime.parse(val);
                  });
                },
                validator: (val) {
                  // print(val);
                  return null;
                },
                // onSaved: (val) => print(val),
              ),

              // Add button:
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Material(
                  color: hasValidData() ? Colors.purple : Colors.grey,
                  // borderRadius: BorderRadius.circular(12.0),
                  elevation: 5,
                  child: MaterialButton(
                    disabledColor: Colors.grey,
                    onPressed: !hasValidData() ? null : submitData,
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

  bool hasValidData() {
    bool result = false;
    if (title.isNotEmpty && amount != 0) {
      result = true;
    }
    return result;
  }

  void submitData() {
    if (title.isNotEmpty && amount != 0) {
      widget.onAddTransactionHandler(title, amount, executionDate);
    }
    Navigator.pop(context);
  }
}
