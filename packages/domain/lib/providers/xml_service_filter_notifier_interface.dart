import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class XmlServiceFilterNotifierInterface
    implements ValueNotifier<Map<PlatformFile, Datafile>?>, FlutterReadonlySignal<Map<PlatformFile, Datafile>?> {
  FlutterSignal<bool> get isFiltering;

  Future<void> filter();
}
