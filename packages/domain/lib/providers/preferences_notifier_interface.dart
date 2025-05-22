import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class PreferencesNotifierInterface extends ChangeNotifier {
  Preferences get value;

  Future<void> init();

  Future<void> save(final Preferences newValue);
}
