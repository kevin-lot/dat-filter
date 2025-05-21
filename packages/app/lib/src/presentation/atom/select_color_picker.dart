import 'package:app/src/presentation/organism/color_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class SelectColorPicker extends StatefulWidget {
  const SelectColorPicker({
    required this.firstValue,
    required this.onChanged,
    super.key,
  });

  final Color? firstValue;
  final ValueChanged<Color> onChanged;

  @override
  State<SelectColorPicker> createState() => _SelectColorPicker();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('firstValue', firstValue))
      ..add(DiagnosticsProperty<ValueChanged<Color>>('onChanged', onChanged));
  }
}

class _SelectColorPicker extends State<SelectColorPicker> {
  late Color _pickedColor;

  @override
  void initState() {
    super.initState();
    _pickedColor = widget.firstValue ?? YaruVariant.accents[0].color;
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 128,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: _pickedColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (final BuildContext context) {
                return ColorPanel(
                  availableYaruVariants: YaruVariant.accents,
                  selected: _pickedColor,
                  onChanged: (final YaruVariant variant) {
                    setState(() {
                      _pickedColor = variant.color;
                      widget.onChanged(variant.color);
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
