import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart' show ThemeMode;

abstract interface class ThemeModeNotifierInterface extends ChangeNotifier {
  ThemeMode get value;

  void setThemeMode(final ThemeMode newValue);
}
