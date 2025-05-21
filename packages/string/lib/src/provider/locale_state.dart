import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:infra/infra_repositories.dart';
import 'package:string/string.dart';

class LocaleNotifier extends ChangeNotifier {
  LocaleNotifier(final Preferences preferences) : value = _init(preferences);

  static Locale _init(final Preferences preferences) {
    // Get first supported locale.
    if (preferences.language == null) return AppLocalizations.supportedLocales[0];

    return Locale(preferences.language!);
  }

  Locale value;

  void choose(final Locale newValue) {
    if (value == newValue) return;
    assert(AppLocalizations.supportedLocales.contains(newValue), 'Locale cannot be found');

    value = newValue;
    notifyListeners();
  }
}
