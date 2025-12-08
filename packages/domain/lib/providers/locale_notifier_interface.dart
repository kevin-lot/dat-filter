import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:signals/signals_flutter.dart';

abstract interface class LocaleNotifierInterface implements ValueNotifier<Locale>, FlutterReadonlySignal<Locale> {}
