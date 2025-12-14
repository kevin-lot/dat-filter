import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> implements ThemeModeNotifierInterface {
  ThemeModeNotifier(this._preferences);

  final Preferences _preferences;

  @override
  ThemeMode get value => state;

  @override
  ThemeMode build() {
    state = _preferences.themeMode ?? ThemeMode.system;
    return state;
  }

  @override
  void setThemeMode(final ThemeMode newValue) {
    state = newValue;
  }
}
