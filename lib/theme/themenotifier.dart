import 'package:flutter/material.dart';

import 'themes.dart';


class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getTheme([bool? isDarkMode]) {
    if (_isDarkMode) {
      return AppTheme.darkTheme;
    } else {
      return AppTheme.lightTheme;
    }
  }

 
}
