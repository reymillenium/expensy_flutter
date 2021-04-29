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
import 'package:expensy_flutter/helpers/string_helper.dart';

// Utilities:

class EditTransactionScreen extends StatefulWidget {
  // Properties:
  final int index;
  final String title;
  final double amount;
  final DateTime executionDate;
  final Function onUpdateTransactionHandler;

  // Constructor:
  EditTransactionScreen({
    this.index,
    this.title,
    this.amount,
    this.executionDate,
    this.onUpdateTransactionHandler,
  });

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  // Sate Properties:
  int _index;
  String _title;
  double _amount;
  DateTime _executionDate;
  Function _onUpdateTransactionHandler;

  // void Function(int, String, double, DateTime) _onUpdateTransactionHandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = widget.index;
    _title = widget.title;
    _amount = widget.amount;
    _executionDate = widget.executionDate;
    _onUpdateTransactionHandler = widget.onUpdateTransactionHandler;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final oneHundredYearsAgo = now.subtract(new Duration(days: 365 * 100));
    final oneHundredYearsFromNow = now.add(new Duration(days: 365 * 100));
    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    final String initialAmountLabel = 'USD(\$) ${currencyFormat.format(_amount)}';

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
                'Update Transaction',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                ),
              ),

              // Title Input
              TextFormField(
                initialValue: _title,
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
                    _title = newText;
                  });
                },
                onFieldSubmitted: hasValidData() ? (_) => () => updateData(context) : null,
              ),

              // Amount Input
              TextFormField(
                initialValue: initialAmountLabel,
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
                onChanged: (String amountText) {
                  setState(() {
                    _amount = StringHelper.extractDoubleOrZero(amountText);
                  });
                },
                onFieldSubmitted: hasValidData() ? (_) => () => updateData(context) : null,
              ),

              // DateTime picker
              DateTimePicker(
                // type: DateTimePickerType.dateTimeSeparate,
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: _executionDate.toString(),
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
                    _executionDate = DateTime.parse(val);
                  });
                },
                validator: (val) {
                  // print(val);
                  return null;
                },
                // onSaved: (val) => print(val),
              ),

              // Update button:
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Material(
                  color: hasValidData() ? Colors.purple : Colors.grey,
                  // borderRadius: BorderRadius.circular(12.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    disabledColor: Colors.grey,
                    onPressed: hasValidData() ? () => updateData(context) : null,
                    // minWidth: 300.0,
                    minWidth: double.infinity,
                    height: 42.0,
                    child: Text(
                      'Update',
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
    if (_title.isNotEmpty && _amount != 0) {
      result = true;
    }
    return result;
  }

  void updateData(BuildContext context) {
    if (_title.isNotEmpty && _amount != 0) {
      _onUpdateTransactionHandler(_index, _title, _amount, _executionDate);
    }
    Navigator.pop(context);
  }
}
