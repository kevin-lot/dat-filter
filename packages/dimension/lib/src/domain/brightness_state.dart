import 'package:flutter/material.dart';
import 'package:infra/infra_repositories.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeNotifier(final Preferences preferences) : value = preferences.themeMode ?? ThemeMode.light;

  ThemeMode value;

  void setThemeMode(final ThemeMode newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
