import 'dart:ui' show Locale;

import 'package:domain/domain.dart';
import 'package:riverpod/riverpod.dart';
import 'package:string/string.dart';

class LocaleNotifier extends Notifier<Locale?> implements LocaleNotifierInterface {
  LocaleNotifier(this._preferences);

  final Preferences _preferences;

  @override
  Locale? get value => state;

  @override
  Locale? build() {
    state = _preferences.locale;
    return state;
  }

  @override
  void choose(final Locale newValue) {
    assert(AppLocalizations.supportedLocales.contains(newValue), 'Locale cannot be found');

    state = newValue;
  }
}
