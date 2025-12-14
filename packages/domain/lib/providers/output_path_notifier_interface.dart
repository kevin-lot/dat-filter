import 'package:riverpod/riverpod.dart';

abstract interface class OutputPathNotifierInterface extends Notifier<String?> {
  String? get value;

  void clear();

  void set(final String newValue);
}
