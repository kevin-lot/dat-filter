import 'package:flutter/material.dart';
import 'package:infra/infra_repositories.dart';

class ColorNotifier extends ChangeNotifier {
  ColorNotifier(final Preferences preferences) : value = preferences.themeColor;

  Color? value;

  void setColor(final Color newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
