import 'dart:async';

import 'package:collection/collection.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository implements PreferencesRepositoryInterface {
  static String configRegionsFirstMatchKey = 'config_regions_first_match';
  static String configRegionsKey = 'config_regions';
  static String languageKey = 'language';
  static String themeColorKey = 'theme_color';
  static String themeModeKey = 'theme_mode';

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  @override
  Future<bool?> getConfigRegionsFirstMatch() async {
    return await _asyncPrefs.getBool(configRegionsFirstMatchKey);
  }

  // ignore: avoid_positional_boolean_parameters
  @override
  Future<void> setConfigRegionsFirstMatch(final bool value) async {
    await _asyncPrefs.setBool(configRegionsFirstMatchKey, value);
  }

  @override
  Future<List<Region>?> getConfigRegions() async {
    final List<String>? codes = await _asyncPrefs.getStringList(configRegionsKey);
    if (codes == null) return null;

    return allRegions
        .where((final Region el) => codes.any((final String code) => code == el.code))
        .map((final Region el) => el.setSelected(true))
        .toList();
  }

  @override
  Future<void> setConfigRegions(final List<Region> value) async {
    await _asyncPrefs.setStringList(
      configRegionsKey,
      value.where((final Region el) => el.isSelected).map((final Region el) => el.code).toList(),
    );
  }

  @override
  Future<Locale?> getLocale() async {
    final String? value = await _asyncPrefs.getString(languageKey);
    if (value == null) return null;

    try {
      return Locale(value);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> setLocale(final Locale value) async {
    await _asyncPrefs.setString(languageKey, value.languageCode);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String? value = await _asyncPrefs.getString(themeModeKey);
    return ThemeMode.values.firstWhereOrNull((final ThemeMode el) => el.name == value) ?? ThemeMode.system;
  }

  @override
  Future<void> setThemeMode(final ThemeMode value) async {
    await _asyncPrefs.setString(themeModeKey, value.name);
  }

  @override
  Future<Color?> getThemeColor() async {
    final int? value = await _asyncPrefs.getInt(themeColorKey);
    if (value == null) return null;

    try {
      return Color(value);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> setThemeColor(final Color value) async {
    await _asyncPrefs.setInt(themeColorKey, value.toARGB32());
  }
}
