import 'package:domain/domain.dart';
import 'package:riverpod/riverpod.dart';

abstract interface class PreferencesNotifierInterface extends AsyncNotifier<Preferences> {
  Preferences get value;

  Future<void> save(final Preferences newValue);
}
