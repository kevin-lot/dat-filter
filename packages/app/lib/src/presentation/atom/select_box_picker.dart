import 'package:dimension/dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectBoxPicker<T> extends StatelessWidget {
  const SelectBoxPicker({
    required this.selectedValue,
    required this.onChanged,
    required this.values,
    super.key,
  });

  final T selectedValue;
  final void Function(T) onChanged; // ignore: unsafe_variance
  final List<(String, T)> values;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: MagicSpaces.selectBoxSize,
      child: InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: Spaces.primary),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isDense: true,
            items: <DropdownMenuItem<T>>[
              for (final (String, T) value in values)
                DropdownMenuItem<T>(
                  value: value.$2,
                  child: Text(value.$1),
                ),
            ],
            onChanged: (final T? newValue) {
              if (newValue == null) {
                return;
              }
              onChanged(newValue);
            },
            value: selectedValue,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('selectedValue', selectedValue))
      ..add(DiagnosticsProperty<void Function(T)>('onChanged', onChanged))
      ..add(DiagnosticsProperty<List<(String, T)>>('values', values));
  }
}
