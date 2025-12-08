import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:signals/signals_flutter.dart';

abstract interface class ThemeColorNotifierInterface implements ValueNotifier<Color?>, FlutterReadonlySignal<Color?> {}
