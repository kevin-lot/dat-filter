import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class OutputPathNotifierInterface extends ChangeNotifier {
  String? get value;

  void clear();

  void set(final String newValue);
}
