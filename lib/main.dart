// Packages:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens:
import 'package:expensy_flutter/screens/transactions_screen.dart';

// Models:
import 'package:expensy_flutter/models/app_data.dart';

// Components:

// Helpers:

// Utilities:

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    ThemeData currentThemeData = appData.currentThemeData;
    final String appTitle = 'Expensy';

    return MaterialApp(
      title: appTitle,
      theme: currentThemeData,
      debugShowCheckedModeBanner: false,
      home: TransactionsScreen(title: appTitle),
    );
  }
}
