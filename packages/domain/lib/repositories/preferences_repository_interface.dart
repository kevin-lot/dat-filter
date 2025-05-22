import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

abstract class PreferencesRepositoryInterface {
  Future<List<Region>?> getConfigRegions();

  Future<bool?> getConfigRegionsFirstMatch();

  Future<Color?> getThemeColor();

  Future<Locale?> getLocale();

  Future<ThemeMode> getThemeMode();

  Future<void> setConfigRegions(final List<Region> value);

  Future<void> setConfigRegionsFirstMatch(final bool value);

  Future<void> setLocale(final Locale value);

  Future<void> setThemeColor(final Color value);

  Future<void> setThemeMode(final ThemeMode value);
}
