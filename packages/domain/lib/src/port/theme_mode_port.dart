import 'package:flutter/material.dart';

interface class ThemeModePort extends ChangeNotifier {
  late ThemeMode value;

  void setThemeMode(final ThemeMode newValue) {}
}
