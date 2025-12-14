import 'dart:async';

import 'package:collection/collection.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository implements PreferencesRepositoryInterface {
  // ignore: non_constant_identifier_names
  static String CONFIG_REGIONS_FIRST_MATCH_KEY = 'config_regions_first_match';
  // ignore: non_constant_identifier_names
  static String CONFIG_REGIONS_KEY = 'config_regions';
  // ignore: non_constant_identifier_names
  static String LANGUAGE_KEY = 'language';
  // ignore: non_constant_identifier_names
  static String THEME_COLOR_KEY = 'theme_color';
  // ignore: non_constant_identifier_names
  static String THEME_MODE_KEY = 'theme_mode';

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  @override
  Future<bool?> getConfigRegionsFirstMatch() async {
    return await _asyncPrefs.getBool(CONFIG_REGIONS_FIRST_MATCH_KEY);
  }

  // ignore: avoid_positional_boolean_parameters
  @override
  Future<void> setConfigRegionsFirstMatch(final bool value) async {
    await _asyncPrefs.setBool(CONFIG_REGIONS_FIRST_MATCH_KEY, value);
  }

  @override
  Future<List<Region>?> getConfigRegions() async {
    final List<String>? codes = await _asyncPrefs.getStringList(CONFIG_REGIONS_KEY);
    if (codes == null) return null;

    return allRegions
        .where((final Region el) => codes.any((final String code) => code == el.code))
        .map((final Region el) => el.setSelected(true))
        .toList();
  }

  @override
  Future<void> setConfigRegions(final List<Region> value) async {
    await _asyncPrefs.setStringList(
      CONFIG_REGIONS_KEY,
      value.where((final Region el) => el.isSelected).map((final Region el) => el.code).toList(),
    );
  }

  @override
  Future<Locale?> getLocale() async {
    final String? value = await _asyncPrefs.getString(LANGUAGE_KEY);
    if (value == null) return null;

    try {
      return Locale(value);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> setLocale(final Locale value) async {
    await _asyncPrefs.setString(LANGUAGE_KEY, value.languageCode);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String? value = await _asyncPrefs.getString(THEME_MODE_KEY);
    return ThemeMode.values.firstWhereOrNull((final ThemeMode el) => el.name == value) ?? ThemeMode.system;
  }

  @override
  Future<void> setThemeMode(final ThemeMode value) async {
    await _asyncPrefs.setString(THEME_MODE_KEY, value.name);
  }

  @override
  Future<Color?> getThemeColor() async {
    final int? value = await _asyncPrefs.getInt(THEME_COLOR_KEY);
    if (value == null) return null;

    try {
      return Color(value);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> setThemeColor(final Color value) async {
    await _asyncPrefs.setInt(THEME_COLOR_KEY, value.toARGB32());
  }
}
