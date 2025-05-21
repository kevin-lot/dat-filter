import 'package:app/src/presentation/atom/select_color_picker.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';

class ThemePicker extends WatchingWidget {
  const ThemePicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final Color color = watchPropertyValue((final ColorNotifier s) => s.value) ?? YaruVariant.accents[0].color;

    return SelectColorPicker(
      onChanged: (final Color newValue) => di<ColorNotifier>().setColor(newValue),
      firstValue: color,
    );
  }
}
