import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class OutputPathNotifierInterface implements ValueNotifier<String?>, FlutterReadonlySignal<String?> {
  void clear();
}
