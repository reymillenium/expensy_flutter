// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:
import 'package:expensy_flutter/screens/transactions_screen.dart';

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:

// Helpers:

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';

void main() {
  // Disables the Landscape mode:
  // WidgetsFlutterBinding.ensureInitialized(); // Without this it might not work in some devices:
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  // With one single provider:
  // runApp(ChangeNotifierProvider(
  //   create: (context) => AppData(),
  //   // child: MyApp(),
  //   child: InitialSplashScreen(),
  // ));

  // With several providers:
  runApp(MultiProvider(
    providers: [
      // Config about the app:
      ChangeNotifierProvider<AppData>(
        create: (context) => AppData(),
      ),

      // Data related to the MonetaryTransaction objects: (sqlite)
      ChangeNotifierProvider<TransactionsData>(
        create: (context) => TransactionsData(),
      ),
    ],
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
        seconds: 2,
        navigateAfterSeconds: MyApp(),
        gradientBackground: LinearGradient(colors: [
          Color(0xFFE5DBDB),
          Colors.white70,
        ]),
        image: Image.asset(
          reymilleniumLocalImage,
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        title: Text(
          'Expensy',
          style: TextStyle(
            fontSize: 60,
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
        photoSize: 80.0,
        onClick: () {},
        loaderColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
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
