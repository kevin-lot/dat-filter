import 'dart:ui';

import 'package:domain/domain.dart' show AppLocalizationsNotifierInterface, LocaleNotifierInterface;
import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:string/string.dart';

/// Watch the locale to get the right one.
class AppLocalizationsNotifier extends SafeChangeNotifier implements AppLocalizationsNotifierInterface {
  AppLocalizationsNotifier(this.localeNotifier) : value = lookupAppLocalizations(localeNotifier.value) {
    localeNotifier.addListener(_onDependencyChanged);
  }

  final LocaleNotifierInterface localeNotifier;

  @override
  AppLocalizations value;

  void _onDependencyChanged() {
    final Locale locale = localeNotifier.value;
    value = lookupAppLocalizations(locale);
    notifyListeners();
  }
}
