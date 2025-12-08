import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class RegionsFirstMatchNotifierInterface
    implements ValueNotifier<bool>, FlutterReadonlySignal<bool> {
  void toggle();
}
