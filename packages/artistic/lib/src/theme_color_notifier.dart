import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ThemeColorNotifier extends Notifier<Color?> implements ThemeColorNotifierInterface {
  ThemeColorNotifier(this._preferences);

  final Preferences _preferences;

  @override
  Color? get value => state;

  @override
  Color? build() {
    state = _preferences.themeColor;
    return state;
  }

  @override
  void setColor(final Color newValue) {
    state = newValue;
  }
}
