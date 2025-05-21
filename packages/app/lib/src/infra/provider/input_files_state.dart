import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickerResultNotifier extends ChangeNotifier {
  FilePickerResult? value;

  void set(final FilePickerResult newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }

  void removeAt(final int index) {
    if (value == null) return;

    try {
      final List<PlatformFile> newList = [...value!.files]..removeAt(index); // prevent reference
      value = FilePickerResult(newList);
    } on RangeError {
    } on Error {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
