import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ThemeColorNotifier extends ChangeNotifier implements ThemeColorNotifierInterface {
  ThemeColorNotifier(final Preferences preferences) : value = preferences.themeColor;

  Color? value;

  void setColor(final Color newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
