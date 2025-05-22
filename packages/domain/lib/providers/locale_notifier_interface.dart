import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class LocaleNotifierInterface extends ChangeNotifier {
  Locale get value;

  void choose(final Locale newValue);
}
