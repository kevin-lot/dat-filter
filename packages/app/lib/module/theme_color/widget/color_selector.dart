import 'package:app/module/theme_color/widget/color_panel.dart';
import 'package:domain/domain.dart' show ThemeColorNotifierInterface;
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';
import 'package:yaru/yaru.dart';

class ColorSelector extends WatchingWidget {
  const ColorSelector({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final Color color =
        watchPropertyValue((final ThemeColorNotifierInterface n) => n.value) ?? YaruVariant.accents[0].color;
    final OutlinedBorder shape = OutlinedButtonTheme.of(context).style?.shape?.resolve({}) ??
        RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.outline));

    return ConstrainedBox(
      constraints: const BoxConstraints.tightForFinite(height: 32),
      child: DecoratedBox(
        decoration: ShapeDecoration(shape: shape),
        child: Material(
          color: color,
          clipBehavior: Clip.antiAlias,
          shape: shape,
          child: InkWell(
            onTap: () async {
              await showDialog(
                builder: (final BuildContext context) {
                  return ColorPanel(
                    availableYaruVariants: YaruVariant.accents,
                    onChanged: (final YaruVariant variant) => di<ThemeColorNotifierInterface>().setColor(variant.color),
                  );
                },
                context: context,
              );
            },
          ),
        ),
      ),
    );
  }
}
