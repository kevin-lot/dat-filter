import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

interface class PreferencesPort extends ChangeNotifier {
  void init() {}

  late Preferences value;

  Future<void> save(final Preferences newValue) async {}

  void set(final Preferences newValue) {}
}
