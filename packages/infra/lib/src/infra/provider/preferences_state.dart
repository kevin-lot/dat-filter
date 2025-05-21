import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infra/src/domain/model/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension on SharedPreferencesAsync {
  Future<ThemeMode> getThemeMode(final String key) async {
    final String? value = await getString(key);

    return ThemeMode.values.firstWhereOrNull((final ThemeMode el) => el.name == value) ?? ThemeMode.system;
  }

  Future<Color?> getColor(final String key) async {
    final int? value = await getInt(key);
    return value == null ? null : Color(value);
  }
}

/// act like a repository
class PreferencesNotifier extends ChangeNotifier {
  PreferencesNotifier(this.sharedPreferencesAsync);

  final SharedPreferencesAsync sharedPreferencesAsync;

  Future<void> init() async {
    if (_completer != null) return;

    final completer = Completer<Preferences>();
    _completer = completer;

    try {
      completer.complete(
        Preferences(
          // configRegions: await sharedPreferencesAsync.getListStringOverride(configRegionsKey),
          configRegions: await sharedPreferencesAsync.getStringList(configRegionsKey),
          configRegionsFirstMatch: await sharedPreferencesAsync.getBool(configRegionsFirstMatchKey),
          language: await sharedPreferencesAsync.getString(languageKey),
          themeColor: await sharedPreferencesAsync.getColor(themeColorKey),
          themeMode: await sharedPreferencesAsync.getThemeMode(themeModeKey),
        ),
      );
    } on Error {
      completer.complete(const Preferences());
    } on Exception {
      completer.complete(const Preferences());
    }

    value = await _completer!.future;
  }

  static Completer<Preferences>? _completer;
  static String configRegionsFirstMatchKey = 'config_regions_first_match';
  static String configRegionsKey = 'config_regions';
  static String languageKey = 'language';
  static String themeColorKey = 'theme_color';
  static String themeModeKey = 'theme_mode';

  bool isLoading = true;
  late Preferences value;

  Future<void> save(final Preferences newValue) async {
    if (newValue == value) return;

    isLoading = true;
    notifyListeners();

    if (newValue.language != null) {
      await sharedPreferencesAsync.setString(languageKey, newValue.language!);
    }
    if (newValue.configRegions != null) {
      await sharedPreferencesAsync.setStringList(configRegionsKey, newValue.configRegions!);
    }
    if (newValue.configRegionsFirstMatch != null) {
      await sharedPreferencesAsync.setBool(configRegionsFirstMatchKey, newValue.configRegionsFirstMatch!);
    }
    if (newValue.themeMode != null) {
      await sharedPreferencesAsync.setString(themeModeKey, newValue.themeMode!.name);
    }
    if (newValue.themeColor != null) {
      await sharedPreferencesAsync.setInt(themeColorKey, newValue.themeColor!.toARGB32());
    }

    isLoading = false;
    notifyListeners();
  }

  void set(final Preferences newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }
}
