import 'dart:ui' show Locale;

import 'package:domain/domain.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string/string.dart';

class LocaleNotifier extends Signal<Locale> with ValueNotifierSignalMixin<Locale> implements LocaleNotifierInterface {
  LocaleNotifier(final Preferences preferences) : super(preferences.locale ?? AppLocalizations.supportedLocales[0]);

  // Overriden to prevent bad set
  @override
  bool set(
    final Locale val, {
    /// Skip equality check and update the value
    final bool force = false,
  }) {
    assert(AppLocalizations.supportedLocales.contains(val), 'Locale cannot be found');

    return super.set(val, force: force);
  }
}
