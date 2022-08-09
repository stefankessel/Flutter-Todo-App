import 'package:flutter/material.dart';
import 'theme_preferences.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;
  final ThemePreferences _themePreferences = ThemePreferences();
  bool get isDarkMode => _isDarkMode;

  ThemeService() {
    getPreferences();
  }

  void toogleTheme() {
    _isDarkMode = !_isDarkMode;
    _themePreferences.setThemePreference(_isDarkMode);
    notifyListeners();
  }

  void getPreferences() async {
    _isDarkMode = await _themePreferences.getThemePreference();
    notifyListeners();
  }
}