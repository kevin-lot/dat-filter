import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListTileContainer extends StatelessWidget {
  const ListTileContainer({
    required this.first,
    required this.second,
    required this.third,
    super.key,
  });

  final Widget first;
  final Widget second;
  final Widget third;

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('first', first))
      ..add(DiagnosticsProperty<Widget>('second', second))
      ..add(DiagnosticsProperty<Widget>('third', third));
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(flex: 4, child: first),
        Expanded(flex: 1, child: second),
        Expanded(flex: 1, child: third),
      ],
    );
  }
}
