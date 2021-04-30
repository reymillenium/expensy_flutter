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
  Color _primaryColor = Colors.purple;
  List<Map> _availablePrimaryColors = [
    {
      'name': 'Red',
      'color': Colors.red,
    },
    {
      'name': 'Purple',
      'color': Colors.purple,
    },
    {
      'name': 'Blue',
      'color': Colors.blue,
    },
  ];

  // Getters:
  get primaryColor {
    return _primaryColor;
  }

  get availablePrimaryColorsCount {
    return _availablePrimaryColors.length;
  }

  UnmodifiableListView<Map> get availablePrimaryColors {
    return UnmodifiableListView(_availablePrimaryColors);
  }

  void setPrimaryColor(Color primaryColor) {
    _primaryColor = primaryColor;
    notifyListeners();
  }
}
