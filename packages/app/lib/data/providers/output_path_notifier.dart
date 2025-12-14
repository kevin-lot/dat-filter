import 'package:domain/domain.dart' show OutputPathNotifierInterface;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutputPathNotifier extends Notifier<String?> implements OutputPathNotifierInterface {
  @override
  String? get value => state;

  @override
  String? build() {
    state = null;
    return state;
  }

  @override
  void clear() {
    state = null;
  }

  @override
  void set(final String newValue) {
    state = newValue;
  }
}
