import 'package:flutter/material.dart';
import 'package:roomie/config/theme.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.Dark;

  toggleTheme() {
    print("vared theme ");
    print(_themeType);

    if (_themeType == ThemeType.Dark) {
      print("if 1");
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      print("if 2");
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}