import 'package:app/src/presentation/atom/select_box_picker.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class BrightnessPicker extends WatchingWidget {
  const BrightnessPicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final ThemeMode themeMode = watchPropertyValue((final ThemeModePort m) => m.value);

    final List<(String, ThemeMode)> values = ThemeMode.values.map((final ThemeMode el) => (el.name, el)).toList();

    return SelectBoxPicker<ThemeMode>(
      onChanged: (final ThemeMode newValue) => di<ThemeModePort>().setThemeMode(newValue),
      selectedValue: themeMode,
      values: values,
    );
  }
}
