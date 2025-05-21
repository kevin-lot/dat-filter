import 'package:dimension/dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';
import 'package:yaru/widgets.dart';

class ColorPanel extends WatchingWidget {
  const ColorPanel({
    required this.availableYaruVariants,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<YaruVariant> availableYaruVariants;
  final Color selected;
  final ValueChanged<YaruVariant> onChanged;

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('selected', selected))
      ..add(DiagnosticsProperty<List<YaruVariant>>('availableColors', availableYaruVariants))
      ..add(DiagnosticsProperty<ValueChanged<YaruVariant>>('onChanged', onChanged));
  }

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: MagicSpaces.dialogMarginLarge,
        vertical: MagicSpaces.dialogMarginPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spaces.primary),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Wrap(
                children: [
                  for (final variant in availableYaruVariants)
                    YaruColorDisk(
                      color: variant.color,
                      onPressed: () => onChanged(variant),
                      selected: selected == variant.color,
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(appLocalizations.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
