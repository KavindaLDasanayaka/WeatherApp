import 'package:flutter/material.dart';
import 'package:weatherapp/services/theme_persistance.dart';
import 'package:weatherapp/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  //anthimta
  ThemeProvider() {
    _loadTheme();
  }

  //initial theme ekak set karanawa
  ThemeData _themeData = ThemesModeData().lightMode;

  //thePersistance object eka hadagananwa
  final ThemePersistance _themePersistance = ThemePersistance();

  //getter
  ThemeData get getThemeData => _themeData;

  //setter -- meka hadanne yata eka hadala
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //load the theme from shared preferences
  Future<void> _loadTheme() async {
    bool isDark = await _themePersistance.loadTheme();
    setThemeData = isDark
        ? ThemesModeData().darkMode
        : ThemesModeData().lightMode;
  }

  //toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData = isDark
        ? ThemesModeData().darkMode
        : ThemesModeData().lightMode;

    await _themePersistance.storeTheme(isDark);
    notifyListeners();
  }
}
