// Packages:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tinycolor/tinycolor.dart'; // Allows to light a color and many other things

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
    // child: MyApp(),
    child: InitialSplashScreen(),
  ));
}

class InitialSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String reymilleniumLocalImage = 'assets/images/reymillenium_logo_1024x1024.png';

    return MaterialApp(
      home: SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(colors: [
          Color(0xFFE5DBDB),
          Colors.white70,
        ]),
        navigateAfterSeconds: MyApp(),
        image: Image.asset(
          reymilleniumLocalImage,
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        title: Text(
          'Expensy',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            fontFamily: 'Luminari',
            color: Colors.black54,
          ),
        ),
        loadingText: Text(
          'Version 1.0.1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        photoSize: 100.0,
        onClick: () {},
        loaderColor: Colors.red,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    ThemeData currentThemeData = appData.currentThemeData;
    Map currentThemeFont = appData.currentThemeFont;
    final String appTitle = 'Expensy';

    return MaterialApp(
      title: appTitle,
      // theme: currentThemeData,
      theme: currentThemeData.copyWith(
        textTheme: currentThemeData.textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: currentThemeFont['fontFamily'],
            // color: currentThemeData.textTheme.headline6.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: currentThemeData.appBarTheme.copyWith(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.yellow,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TransactionsScreen(title: appTitle),
    );
  }
}
