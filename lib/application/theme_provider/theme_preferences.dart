import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const THEME_PREFERENCE_KEY = "THEME_PREFERENCE_KEY";

  Future<bool> getThemePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_PREFERENCE_KEY) ?? false;
  }

  setThemePreference(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_PREFERENCE_KEY, value);
  }
}