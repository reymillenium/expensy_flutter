// Packages:
import 'package:flutter/material.dart';

// Screens:
import 'package:expensy_flutter/screens/transactions_screen.dart';

// Models:

// Components:

// Helpers:

// Utilities:

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionsScreen(title: 'Expensy'),
    );
  }
}
