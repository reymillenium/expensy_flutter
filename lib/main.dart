// Packages:
import 'package:flutter/material.dart';

// Screens:
import 'package:expensy_flutter/screens/expenses_screen.dart';

// Models:

// Components:

// Helpers:

// Utilities:

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpensesScreen(title: 'Expensy'),
    );
  }
}
