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
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
    },
    {
      'name': 'Red',
      'theme': ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
    },
    {
      'name': 'Blue',
      'theme': ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
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
