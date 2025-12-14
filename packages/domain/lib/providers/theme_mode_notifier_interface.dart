import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod/riverpod.dart';

abstract interface class ThemeModeNotifierInterface extends Notifier<ThemeMode> {
  ThemeMode get value;

  void setThemeMode(final ThemeMode newValue);
}
