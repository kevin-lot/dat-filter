import 'dart:ui';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

/// Watch the locale to get the right one.
class AppLocalizationsNotifier extends SafeChangeNotifier {
  AppLocalizationsNotifier(this.localeNotifier) : value = lookupAppLocalizations(di<LocaleNotifier>().value) {
    localeNotifier.addListener(_onDependencyChanged);
  }

  final LocaleNotifier localeNotifier;
  AppLocalizations value;

  void _onDependencyChanged() {
    final Locale locale = di<LocaleNotifier>().value;
    value = lookupAppLocalizations(locale);
    notifyListeners();
  }
}
