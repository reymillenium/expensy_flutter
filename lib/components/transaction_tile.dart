// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:

// Helpers:

// Utilities:

class TransactionsTile extends StatelessWidget {
  // Properties:
  final Transaction transaction;

  // Constructor:
  TransactionsTile({this.transaction});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formattedDate = formatter.format(transaction.createAt);

    return Card(
      // shadowColor: Colors.purpleAccent,
      color: Colors.white70,
      // margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        // side: BorderSide(color: Colors.red, width: 1),
        // borderRadius: BorderRadius.circular(10),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Leading
            CircleAvatar(
              radius: 30,
              child: Container(
                child: Text('${transaction.amount.toString()}'),
              ),
            ),

            // Title
            Column(
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(formattedDate),
              ],
            ),

            //  Trailing
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    // color: Colors.purple,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    // color: Colors.purple,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
