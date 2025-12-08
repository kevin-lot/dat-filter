import 'package:file_picker/file_picker.dart' show FilePickerResult;
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class FilePickerResultNotifierInterface
    implements ValueNotifier<FilePickerResult?>, FlutterReadonlySignal<FilePickerResult?> {
  void removeAt(final int index);
}
