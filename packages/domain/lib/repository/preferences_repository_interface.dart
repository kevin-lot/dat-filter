import 'dart:ui' show Color, Locale;

import 'package:domain/domain.dart' show Region;
import 'package:flutter/material.dart' show ThemeMode;

abstract interface class PreferencesRepositoryInterface {
  Future<List<Region>?> getConfigRegions();

  Future<bool?> getConfigRegionsFirstMatch();

  Future<Color?> getThemeColor();

  Future<Locale?> getLocale();

  Future<ThemeMode> getThemeMode();

  Future<void> setConfigRegions(final List<Region> value);

  // ignore: avoid_positional_boolean_parameters
  Future<void> setConfigRegionsFirstMatch(final bool value);

  Future<void> setLocale(final Locale value);

  Future<void> setThemeColor(final Color value);

  Future<void> setThemeMode(final ThemeMode value);
}
