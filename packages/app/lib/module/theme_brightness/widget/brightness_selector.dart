import 'package:domain/domain.dart' show ThemeModeNotifierInterface;
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class BrightnessSelector extends WatchingWidget {
  const BrightnessSelector({super.key});

  @override
  Widget build(final BuildContext context) {
    final ThemeMode themeMode = watchPropertyValue((final ThemeModeNotifierInterface m) => m.value);

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
