import 'dart:ui' show Color;

import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class ThemeColorNotifierInterface extends ChangeNotifier {
  Color? get value;

  void setColor(final Color newValue);
}
