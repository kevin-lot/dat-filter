import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class PreferencesNotifier extends ChangeNotifier implements PreferencesNotifierInterface {
  PreferencesNotifier(this._preferencesRepository);

  final PreferencesRepositoryInterface _preferencesRepository;

  @override
  Future<void> init() async {
    if (_completer != null) return;

    final completer = Completer<Preferences>();
    _completer = completer;

    try {
      completer.complete(
        Preferences(
          configRegions: await _preferencesRepository.getConfigRegions(),
          configRegionsFirstMatch: await _preferencesRepository.getConfigRegionsFirstMatch(),
          locale: await _preferencesRepository.getLocale(),
          themeColor: await _preferencesRepository.getThemeColor(),
          themeMode: await _preferencesRepository.getThemeMode(),
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

  @override
  late Preferences value;

  @override
  Future<void> save(final Preferences newValue) async {
    if (newValue == value) return;

    if (newValue.locale != null) {
      await _preferencesRepository.setLocale(newValue.locale!);
    }
    if (newValue.configRegions != null) {
      await _preferencesRepository.setConfigRegions(newValue.configRegions!);
    }
    if (newValue.configRegionsFirstMatch != null) {
      await _preferencesRepository.setConfigRegionsFirstMatch(newValue.configRegionsFirstMatch!);
    }
    if (newValue.themeMode != null) {
      await _preferencesRepository.setThemeMode(newValue.themeMode!);
    }
    if (newValue.themeColor != null) {
      await _preferencesRepository.setThemeColor(newValue.themeColor!);
    }

    notifyListeners();
  }
}
