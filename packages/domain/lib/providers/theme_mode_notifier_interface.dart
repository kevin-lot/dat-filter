import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:flutter/material.dart' show ThemeMode;
import 'package:signals/signals_flutter.dart';

abstract interface class ThemeModeNotifierInterface
    implements ValueNotifier<ThemeMode>, FlutterReadonlySignal<ThemeMode> {}
