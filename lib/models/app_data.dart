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
  ThemeData _currentTheme;
  int _themeIndex = 0;
  List<Map> _availableThemes = [
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

  int _fontIndex = 0;
  List<Map> _availableFonts = [
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
    // _currentTheme = _availableThemes[_themeIndex]['theme'];
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableFonts[_fontIndex]['fontFamily'],
      primarySwatch: _availableThemes[themeIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemes[themeIndex]['theme']['primaryColor'],
      accentColor: _availableThemes[themeIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemes[_themeIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentTheme = newThemeData;
  }

  // Getters:
  get currentTheme {
    return _currentTheme;
  }

  get themeIndex {
    return _themeIndex;
  }

  get availableThemesCount {
    return _availableThemes.length;
  }

  UnmodifiableListView<Map> get availableThemes {
    return UnmodifiableListView(_availableThemes);
  }

  get fontIndex {
    return _fontIndex;
  }

  UnmodifiableListView<Map> get availableFonts {
    return UnmodifiableListView(_availableFonts);
  }

  // Public methods:
  void setCurrentTheme(int themeIndex) {
    _themeIndex = themeIndex;
    // _currentTheme = _availableThemes[themeIndex]['theme'];
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableFonts[_fontIndex]['fontFamily'],
      primarySwatch: _availableThemes[themeIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemes[themeIndex]['theme']['primaryColor'],
      accentColor: _availableThemes[themeIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemes[_themeIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    _currentTheme = newThemeData;
    notifyListeners();
  }

  void setCurrentFontFamily(int fontIndex) {
    ThemeData newThemeData = ThemeData(
      fontFamily: _availableFonts[fontIndex]['fontFamily'],
      primarySwatch: _availableThemes[_themeIndex]['theme']['primarySwatch'],
      primaryColor: _availableThemes[_themeIndex]['theme']['primaryColor'],
      accentColor: _availableThemes[themeIndex]['theme']['accentColor'],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _availableThemes[_themeIndex]['theme']['primaryColor'] == Colors.deepPurple ? Colors.white : Colors.black,
      ),
    );
    // _currentTheme = _availableThemes[themeIndex]['theme'];
    _currentTheme = newThemeData;
    notifyListeners();
  }
}
