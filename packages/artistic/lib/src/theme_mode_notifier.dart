import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeNotifier(final Preferences preferences) : value = preferences.themeMode ?? ThemeMode.system;

  ThemeMode value;

  void setThemeMode(final ThemeMode newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
