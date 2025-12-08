import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class AppLocalizationsNotifierInterface
    implements ValueNotifier<AppLocalizationsInterface>, FlutterReadonlySignal<AppLocalizationsInterface> {}
