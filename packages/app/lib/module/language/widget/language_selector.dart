import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string/string.dart';
import 'package:yaru/widgets.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final Locale? locale = ref.watch(localeNotifierProvider).value?.value;
    if (locale == null) {
      return const SizedBox();
    }

    final List<(String, Locale)> values =
        AppLocalizations.supportedLocales.map((final Locale el) => (el.languageCode, el)).toList();

    return YaruPopupMenuButton<Locale>(
      initialValue: locale,
      itemBuilder: (final context) {
        return [
          for (final value in values) PopupMenuItem(value: value.$2, child: Text(value.$1)),
        ];
      },
      onSelected: (final Locale newValue) => ref.read(localeNotifierProvider).value?.choose(newValue),
      child: Text(locale.languageCode, textAlign: TextAlign.right),
    );
  }
}
