import 'package:app/service_locator.dart';
import 'package:domain/domain.dart' show ThemeModeNotifierInterface;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/widgets.dart';

class BrightnessSelector extends ConsumerWidget {
  const BrightnessSelector({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeMode? themeMode = ref.watch(themeModeNotifierProvider).value?.value;

    if (themeMode == null) {
      return const SizedBox();
    }

    final List<(String, ThemeMode)> values = ThemeMode.values.map((final ThemeMode el) => (el.name, el)).toList();

    return YaruPopupMenuButton<ThemeMode>(
      initialValue: themeMode,
      itemBuilder: (final context) {
        return [
          for (final value in values) PopupMenuItem(value: value.$2, child: Text(value.$1)),
        ];
      },
      onSelected: (final ThemeMode newValue) => di<ThemeModeNotifierInterface>().setThemeMode(newValue),
      child: Text(themeMode.name, textAlign: TextAlign.right),
    );
  }
}
