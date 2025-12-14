import 'dart:ui' show Color;

import 'package:riverpod/riverpod.dart';

abstract interface class ThemeColorNotifierInterface extends Notifier<Color?> {
  Color? get value;

  void setColor(final Color newValue);
}
