import 'package:flutter/foundation.dart';

class OutputPathNotifier with ChangeNotifier {
  String? value;

  void clear() {
    value = null;
    notifyListeners();
  }

  void set(final String newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
