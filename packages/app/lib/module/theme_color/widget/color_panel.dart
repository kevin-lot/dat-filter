import 'dart:io';

import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart' show ThemeColorNotifierInterface;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';
import 'package:yaru/widgets.dart';

class ColorPanel extends StatelessWidget {
  const ColorPanel({
    required this.availableYaruVariants,
    required this.onChanged,
    super.key,
  });

  final List<YaruVariant> availableYaruVariants;
  final ValueChanged<YaruVariant> onChanged;

  @override
  Widget build(final BuildContext context) {
    final YaruWindowControlPlatform controlPlatform =
        !kIsWeb && Platform.isWindows ? YaruWindowControlPlatform.windows : YaruWindowControlPlatform.yaru;
    final Color themeColor =
        watchPropertyValue((final ThemeColorNotifierInterface n) => n.value) ?? YaruVariant.accents[0].color;

    return SimpleDialog(
      contentPadding: const EdgeInsets.all(MagicSpaces.primary),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: MagicSpaces.dialogMarginLarge,
        vertical: MagicSpaces.dialogMarginPrimary,
      ),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: YaruWindowControl(
            onTap: () async => await Navigator.maybePop(context),
            platform: controlPlatform,
            type: YaruWindowControlType.close,
          ),
        ),
        const SizedBox(height: MagicSpaces.primary),
        Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              for (final variant in availableYaruVariants)
                YaruColorDisk(
                  color: variant.color,
                  onPressed: () => onChanged(variant),
                  selected: themeColor == variant.color,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<List<YaruVariant>>('availableColors', availableYaruVariants))
      ..add(DiagnosticsProperty<ValueChanged<YaruVariant>>('onChanged', onChanged));
  }
}
