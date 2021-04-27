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
      title: 'Expensy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: TransactionsScreen(title: 'Expensy'),
    );
  }
}
