import 'dart:ui' show Locale;

import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:string/string.dart';

class LocaleNotifier extends ChangeNotifier implements LocaleNotifierInterface {
  LocaleNotifier(final Preferences preferences) : value = _init(preferences);

  static Locale _init(final Preferences preferences) {
    return preferences.locale ?? AppLocalizations.supportedLocales[0];
  }

  @override
  Locale value;

  @override
  void choose(final Locale newValue) {
    if (value == newValue) return;
    assert(AppLocalizations.supportedLocales.contains(newValue), 'Locale cannot be found');

    value = newValue;
    notifyListeners();
  }
}
