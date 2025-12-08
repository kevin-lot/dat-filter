import 'dart:async';

import 'package:signals/signals_flutter.dart';

abstract interface class XmlServiceSaveNotifierInterface {
  FlutterSignal<bool> get isSaving;

  Future<void> save();
}
