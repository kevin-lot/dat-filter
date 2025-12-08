import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ThemeColorNotifier extends Signal<Color?>
    with ValueNotifierSignalMixin<Color?>
    implements ThemeColorNotifierInterface {
  ThemeColorNotifier(final Preferences preferences) : super(preferences.themeColor);
}
