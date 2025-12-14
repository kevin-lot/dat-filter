import 'package:riverpod/riverpod.dart';

abstract interface class RegionsFirstMatchNotifierInterface extends Notifier<bool> {
  bool get value;

  void toggle();
}
