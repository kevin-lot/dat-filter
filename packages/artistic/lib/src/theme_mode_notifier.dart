import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ThemeModeNotifier extends Signal<ThemeMode>
    with ValueNotifierSignalMixin<ThemeMode>
    implements ThemeModeNotifierInterface {
  ThemeModeNotifier(final Preferences preferences) : super(preferences.themeMode ?? ThemeMode.system);
}
