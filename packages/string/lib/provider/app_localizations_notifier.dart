import 'dart:ui';

import 'package:domain/domain.dart'
    show AppLocalizationsInterface, AppLocalizationsNotifierInterface, LocaleNotifierInterface;
import 'package:signals/signals_flutter.dart';
import 'package:string/string.dart';

/// Watch the locale to get the right one.
class AppLocalizationsNotifier extends Signal<AppLocalizationsInterface>
    with ValueNotifierSignalMixin<AppLocalizationsInterface>
    implements AppLocalizationsNotifierInterface {
  AppLocalizationsNotifier(
    final LocaleNotifierInterface localeNotifier,
  ) : super(lookupAppLocalizations(localeNotifier.value)) {
    _init(localeNotifier);
  }

  void _init(final LocaleNotifierInterface localeNotifier) {
    effect(() {
      value = lookupAppLocalizations(localeNotifier.value);
    });
  }
}
