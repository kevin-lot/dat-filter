import 'dart:ui';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:string/string.dart';

/// Watch the locale to get the right one.
class AppLocalizationsNotifier extends SafeChangeNotifier {
  AppLocalizationsNotifier(this.localeNotifier) : value = lookupAppLocalizations(localeNotifier.value) {
    localeNotifier.addListener(_onDependencyChanged);
  }

  final LocaleNotifier localeNotifier;
  AppLocalizations value;

  void _onDependencyChanged() {
    final Locale locale = localeNotifier.value;
    value = lookupAppLocalizations(locale);
    notifyListeners();
  }
}
