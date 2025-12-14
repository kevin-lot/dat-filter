import 'dart:ui';

import 'package:domain/domain.dart' show AppLocalizationsInterface, AppLocalizationsNotifierInterface;
import 'package:riverpod/riverpod.dart';
import 'package:string/string.dart';

class AppLocalizationsNotifier extends Notifier<AppLocalizationsInterface>
    implements AppLocalizationsNotifierInterface {
  AppLocalizationsNotifier(this._locale);

  final Locale _locale;

  @override
  AppLocalizationsInterface get value => state;

  @override
  AppLocalizationsInterface build() {
    state = lookupAppLocalizations(_locale);
    return state;
  }
}
