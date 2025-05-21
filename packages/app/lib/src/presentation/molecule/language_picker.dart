import 'package:app/src/presentation/atom/select_box_picker.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class LanguagePicker extends WatchingWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final Locale locale = watchPropertyValue((final LocaleNotifier s) => s.value);

    final List<(String, Locale)> supportedLocales =
        AppLocalizations.supportedLocales.map((final Locale el) => (el.languageCode, el)).toList();

    return SelectBoxPicker<Locale>(
      onChanged: (final Locale newValue) => di<LocaleNotifier>().choose(newValue),
      selectedValue: locale,
      values: supportedLocales,
    );
  }
}
