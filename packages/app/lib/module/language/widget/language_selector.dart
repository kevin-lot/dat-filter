import 'package:domain/domain.dart' show LocaleNotifierInterface;
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class LanguageSelector extends WatchingWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(final BuildContext context) {
    final Locale locale = watchPropertyValue((final LocaleNotifierInterface n) => n.value);
    final List<(String, Locale)> values =
        AppLocalizations.supportedLocales.map((final Locale el) => (el.languageCode, el)).toList();

    return YaruPopupMenuButton<Locale>(
      initialValue: locale,
      itemBuilder: (final context) {
        return [
          for (final value in values) PopupMenuItem(value: value.$2, child: Text(value.$1)),
        ];
      },
      onSelected: (final Locale newValue) => di<LocaleNotifierInterface>().choose(newValue),
      child: Text(locale.languageCode, textAlign: TextAlign.right),
    );
  }
}
