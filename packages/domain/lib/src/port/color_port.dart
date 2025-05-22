import 'package:flutter/material.dart';

interface class ColorPort extends ChangeNotifier {
  Color? value;

  void setColor(final Color newValue) {}
}
