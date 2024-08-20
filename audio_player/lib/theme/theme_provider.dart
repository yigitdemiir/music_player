import 'package:audio_player/theme/dark_mode.dart';
import 'package:audio_player/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeMode = lightMode;

  ThemeData get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == darkMode;

  void setThemeMode(ThemeData themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleThemeMode() {
    if (_themeMode == lightMode) {
      setThemeMode(darkMode);
    } else {
      setThemeMode(lightMode);
    }
  }
}
