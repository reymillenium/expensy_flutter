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
      'theme': ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.purpleAccent,
      ),
    },
    {
      'name': 'Indigo',
      'theme': ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    },
    {
      'name': 'Blue',
      'theme': ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
    },
    {
      'name': 'Orange',
      'theme': ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
      ),
    },
    {
      'name': 'Pink',
      'theme': ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
    },
    {
      'name': 'Teal',
      'theme': ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
      ),
    },
    {
      'name': 'Green',
      'theme': ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
      ),
    },
    {
      'name': 'Cyan',
      'theme': ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyanAccent,
      ),
    },
  ];

  AppData() {
    _currentTheme = _availableThemes[_themeIndex]['theme'];
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

  void setCurrentTheme(int themeIndex) {
    _themeIndex = themeIndex;
    _currentTheme = _availableThemes[themeIndex]['theme'];
    notifyListeners();
  }
}
