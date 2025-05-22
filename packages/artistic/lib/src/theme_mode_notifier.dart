import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ThemeModeNotifier extends ChangeNotifier implements ThemeModeNotifierInterface {
  ThemeModeNotifier(final Preferences preferences) : value = preferences.themeMode ?? ThemeMode.system;

  @override
  ThemeMode value;

  @override
  void setThemeMode(final ThemeMode newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
