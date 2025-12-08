/// Example implementations showing how to convert ChangeNotifier-based notifiers
/// to signal-based notifiers.
///
/// This file demonstrates the pattern - you'll need to update your actual
/// notifier implementations following this pattern.

import 'dart:async';
import 'dart:ui' show Color, Locale;

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

// ============================================================================
// Example 1: Simple signal-based notifier (replacing OutputPathNotifier)
// ============================================================================

class OutputPathNotifierSignal implements OutputPathNotifierInterface {
  final Signal<String?> _signal = signal<String?>(null);

  @override
  String? get value => _signal.value;

  @override
  void clear() {
    _signal.value = null;
  }

  @override
  void set(final String newValue) {
    if (newValue != _signal.value) {
      _signal.value = newValue;
    }
  }

  /// Expose the signal for watching in widgets
  ReadonlySignal<String?> get signal => _signal.readonly();
}

// ============================================================================
// Example 2: Signal-based notifier with initialization (replacing LocaleNotifier)
// ============================================================================

class LocaleNotifierSignal implements LocaleNotifierInterface {
  LocaleNotifierSignal(final Preferences preferences) : _signal = signal<Locale>(_init(preferences));

  static Locale _init(final Preferences preferences) {
    return preferences.locale ?? AppLocalizations.supportedLocales[0];
  }

  final Signal<Locale> _signal;

  @override
  Locale get value => _signal.value;

  @override
  void choose(final Locale newValue) {
    assert(AppLocalizations.supportedLocales.contains(newValue), 'Locale cannot be found');
    if (newValue != _signal.value) {
      _signal.value = newValue;
    }
  }

  /// Expose the signal for watching in widgets
  ReadonlySignal<Locale> get signal => _signal.readonly();
}

// ============================================================================
// Example 3: Signal-based notifier with async initialization
// (replacing PreferencesNotifier)
// ============================================================================

class PreferencesNotifierSignal implements PreferencesNotifierInterface {
  PreferencesNotifierSignal(this._preferencesRepository) : _signal = signal<Preferences>(const Preferences());

  final PreferencesRepositoryInterface _preferencesRepository;
  final Signal<Preferences> _signal;
  static Completer<Preferences>? _completer;

  @override
  Preferences get value => _signal.value;

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

    _signal.value = await _completer!.future;
  }

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

    _signal.value = newValue;
  }

  /// Expose the signal for watching in widgets
  ReadonlySignal<Preferences> get signal => _signal.readonly();
}

// ============================================================================
// Example 4: Signal-based notifier that depends on another signal
// (replacing ThemeColorNotifier)
// ============================================================================

class ThemeColorNotifierSignal implements ThemeColorNotifierInterface {
  ThemeColorNotifierSignal(final Preferences preferences) : _signal = signal<Color?>(preferences.themeColor);

  final Signal<Color?> _signal;

  @override
  Color? get value => _signal.value;

  @override
  void setColor(final Color newValue) {
    if (newValue != _signal.value) {
      _signal.value = newValue;
    }
  }

  /// Expose the signal for watching in widgets
  ReadonlySignal<Color?> get signal => _signal.readonly();
}

// ============================================================================
// Note: You'll need to update the interfaces to remove ChangeNotifier
// or create adapter classes that implement both the interface and expose signals
// ============================================================================

/// Alternative approach: Create an adapter that implements the interface
/// but uses signals internally. This allows gradual migration.
abstract class SignalNotifierAdapter {
  /// Subclasses should expose their signal here
  ReadonlySignal get signal;
}

