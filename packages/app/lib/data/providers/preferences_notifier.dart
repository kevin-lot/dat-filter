import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferencesNotifier extends AsyncNotifier<Preferences> implements PreferencesNotifierInterface {
  PreferencesNotifier(this._preferencesRepository);

  final PreferencesRepositoryInterface _preferencesRepository;

  @override
  Preferences get value => state.value ?? const Preferences();

  @override
  Future<Preferences> build() async {
    try {
      final preferences = Preferences(
        configRegions: await _preferencesRepository.getConfigRegions(),
        configRegionsFirstMatch: await _preferencesRepository.getConfigRegionsFirstMatch(),
        locale: await _preferencesRepository.getLocale(),
        themeColor: await _preferencesRepository.getThemeColor(),
        themeMode: await _preferencesRepository.getThemeMode(),
      );
      state = AsyncValue.data(preferences);
      return preferences;
    } on Error catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return const Preferences();
    }
  }

  @override
  Future<void> save(final Preferences newValue) async {
    if (newValue == state.value) return;

    state = const AsyncValue.loading();
    await Future.wait([
      if (newValue.locale != null) _preferencesRepository.setLocale(newValue.locale!),
      if (newValue.configRegions != null) _preferencesRepository.setConfigRegions(newValue.configRegions!),
      if (newValue.configRegionsFirstMatch != null)
        _preferencesRepository.setConfigRegionsFirstMatch(newValue.configRegionsFirstMatch!),
      if (newValue.themeMode != null) _preferencesRepository.setThemeMode(newValue.themeMode!),
      if (newValue.themeColor != null) _preferencesRepository.setThemeColor(newValue.themeColor!),
    ]);
    state = AsyncValue.data(newValue);
  }
}
