// Packages:
import 'package:flutter/material.dart';
import 'dart:math'; // Allows to use: random
import 'dart:convert'; // Allows to use: base64UrlEncode
import 'package:intl/intl.dart'; // Allows to use: DateFormat

// Screens:
import 'package:expensy_flutter/screens/edit_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:

// Helpers:

// Utilities:

class TransactionTile extends StatelessWidget {
  // Properties:
  final Transaction transaction;
  final int index;
  final Function onUpdateTransactionHandler;
  final Function onDeleteTransactionHandler;

  // Constructor:
  TransactionTile({
    this.transaction,
    this.index,
    this.onUpdateTransactionHandler,
    this.onDeleteTransactionHandler,
  });

  @override
  Widget build(BuildContext context) {
    // final DateFormat formatter = DateFormat('MM/dd/yyyy').add_jm();
    final DateFormat formatter = DateFormat().add_yMMMMd();
    final String formattedDate = formatter.format(transaction.executionDate);
    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    final String amountLabel = '\$${currencyFormat.format(transaction.amount)}';
    // final double amountFontSize = 14;
    final double amountFontSize = (84 / amountLabel.length);

    return Card(
      // shadowColor: Colors.purpleAccent,
      elevation: 2,
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
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // Leading
        //     CircleAvatar(
        //       radius: 32,
        //       child: Container(
        //         child: Text(
        //           amountLabel,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontStyle: FontStyle.italic,
        //             fontSize: amountFontSize,
        //           ),
        //         ),
        //       ),
        //     ),
        //
        //     // Title
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           transaction.title,
        //           style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Text(
        //           formattedDate,
        //           style: TextStyle(
        //             color: Colors.black54,
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //     //  Trailing
        //     Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         IconButton(
        //           icon: Icon(
        //             Icons.delete,
        //             // color: Colors.purple,
        //           ),
        //           onPressed: onDeleteTransactionHandler,
        //         ),
        //         IconButton(
        //           icon: Icon(
        //             Icons.edit,
        //             // color: Colors.purple,
        //           ),
        //           onPressed: () {
        //             showModalBottomSheet(
        //               backgroundColor: Colors.transparent,
        //               isScrollControlled: true,
        //               context: context,
        //               builder: (context) => EditTransactionScreen(
        //                 index: index,
        //                 title: transaction.title,
        //                 amount: transaction.amount,
        //                 executionDate: transaction.executionDate,
        //                 onUpdateTransactionHandler: onUpdateTransactionHandler,
        //               ),
        //             );
        //           },
        //         ),
        //       ],
        //     )
        //   ],
        // ),

        child: ListTile(
          // visualDensity: VisualDensity.standard,
          leading: CircleAvatar(
            radius: 32,
            child: Container(
              child: Text(
                amountLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: amountFontSize,
                ),
              ),
            ),
          ),

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: onDeleteTransactionHandler,
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => EditTransactionScreen(
                      index: index,
                      title: transaction.title,
                      amount: transaction.amount,
                      executionDate: transaction.executionDate,
                      onUpdateTransactionHandler: onUpdateTransactionHandler,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
