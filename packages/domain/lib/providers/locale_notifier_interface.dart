import 'dart:ui' show Locale;

import 'package:riverpod/riverpod.dart';

abstract interface class LocaleNotifierInterface extends Notifier<Locale> {
  Locale get value;

  void choose(final Locale newValue);
}
