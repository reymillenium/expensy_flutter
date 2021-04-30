// Packages:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection'; // Allows to use UnmodifiableListView

// Screens:

// Models:

// Components:

// Helpers:

// Utilities:

class AppData extends ChangeNotifier {
  // Properties:
  ThemeData _currentThemeData;
  int _themeColorIndex = 0;
  List<Map> _availableThemeColors = [
    {
      'name': 'Purple',
      'theme': {
        'primarySwatch': Colors.deepPurple,
        'primaryColor': Colors.deepPurple,
        'accentColor': Colors.purpleAccent,
      },
    },
    {
      'name': 'Indigo',
      'theme': {
        'primarySwatch': Colors.indigo,
        'primaryColor': Colors.indigo,
        'accentColor': Colors.indigoAccent,
      },
    },
    {
      'name': 'Blue',
      'theme': {
        'primarySwatch': Colors.blue,
        'primaryColor': Colors.blue,
        'accentColor': Colors.blueAccent,
      },
    },
    {
      'name': 'Orange',
      'theme': {
        'primarySwatch': Colors.deepOrange,
        'primaryColor': Colors.deepOrange,
        'accentColor': Colors.orangeAccent,
      },
    },
    {
      'name': 'Pink',
      'theme': {
        'primarySwatch': Colors.pink,
        'primaryColor': Colors.pink,
        'accentColor': Colors.pinkAccent,
      },
    },
    {
      'name': 'Teal',
      'theme': {
        'primarySwatch': Colors.teal,
        'primaryColor': Colors.teal,
        'accentColor': Colors.tealAccent,
      },
    },
    {
      'name': 'Green',
      'theme': {
        'primarySwatch': Colors.green,
        'primaryColor': Colors.green,
        'accentColor': Colors.greenAccent,
      },
    },
    {
      'name': 'Cyan',
      'theme': {
        'primarySwatch': Colors.cyan,
        'primaryColor': Colors.cyan,
        'accentColor': Colors.cyanAccent,
      },
    },
  ];

  int _themeFontIndex = 0;
  List<Map> _availableThemeFonts = [
    {
      'name': 'Roboto',
      'fontFamily': 'Roboto',
    },
    {
      'name': 'Luminari',
      'fontFamily': 'Luminari',
    },
    {
      'name': 'SourceSansPro',
      'fontFamily': 'SourceSansPro',
    },
  ];

  AppData() {
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[_themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[_themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[_themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
  }

  // Getters:
  get currentThemeData {
    return _currentThemeData;
  }

  get themeColorIndex {
    return _themeColorIndex;
  }

  UnmodifiableListView<Map> get availableThemeColors {
    return UnmodifiableListView(_availableThemeColors);
  }

  get fontIndex {
    return _themeFontIndex;
  }

  UnmodifiableListView<Map> get availableThemeFonts {
    return UnmodifiableListView(_availableThemeFonts);
  }

  // Public methods:
  void setCurrentThemeColor(int themeColorIndex) {
    _themeColorIndex = themeColorIndex;
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[_themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
    notifyListeners();
  }

  void setCurrentFontFamily(int themeFontIndex) {
    _themeFontIndex = themeFontIndex;
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableThemeFonts[themeFontIndex]['fontFamily'],
      primarySwatch: _availableThemeColors[_themeColorIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'],
      accentColor: _availableThemeColors[themeColorIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemeColors[_themeColorIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentThemeData = newThemeData;
    notifyListeners();
  }
}
