import 'package:app/module/theme_color/widget/color_panel.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaru/theme.dart';
import 'package:yaru/yaru.dart';

class ColorSelector extends ConsumerWidget {
  const ColorSelector({
    super.key,
  });

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final Color color = ref.watch(themeColorNotifierProvider).value?.value ?? YaruVariant.accents[0].color;
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
                    onChanged: (final YaruVariant variant) =>
                        ref.read(themeColorNotifierProvider).value?.setColor(variant.color),
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
