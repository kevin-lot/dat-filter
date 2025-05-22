import 'package:file_picker/file_picker.dart' show FilePickerResult;
import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class FilePickerResultNotifierInterface extends ChangeNotifier {
  FilePickerResult? get value;

  void set(final FilePickerResult newValue);

  void removeAt(final int index);
}
