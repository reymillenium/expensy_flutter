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
  List<Map> _availableThemes = [
    {
      'name': 'Purple',
      'theme': ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.purpleAccent,
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
      'name': 'Green',
      'theme': ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
      ),
    },
    {
      'name': 'Pink',
      'theme': ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
    },
  ];

  AppData() {
    _currentTheme = _availableThemes[0]['theme'];
  }

  // Getters:
  get currentTheme {
    return _currentTheme;
  }

  get availableThemesCount {
    return _availableThemes.length;
  }

  UnmodifiableListView<Map> get availableThemes {
    return UnmodifiableListView(_availableThemes);
  }

  void setCurrentTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
