import 'package:domain/domain.dart' show OutputPathNotifierInterface;
import 'package:flutter/foundation.dart' show ChangeNotifier;

class OutputPathNotifier extends ChangeNotifier implements OutputPathNotifierInterface {
  @override
  String? value;

  @override
  void clear() {
    value = null;
    notifyListeners();
  }

  @override
  void set(final String newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
