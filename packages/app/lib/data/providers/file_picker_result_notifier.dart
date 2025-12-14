import 'package:domain/domain.dart' show FilePickerResultNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilePickerResultNotifier extends Notifier<FilePickerResult?> implements FilePickerResultNotifierInterface {
  @override
  FilePickerResult? get value => state;

  @override
  FilePickerResult? build() {
    state = null;
    return null;
  }

  @override
  void set(final FilePickerResult newValue) {
    state = newValue;
  }

  @override
  void removeAt(final int index) {
    if (value == null) return;

    try {
      final List<PlatformFile> newList = [...value!.files]..removeAt(index); // prevent reference
      state = FilePickerResult(newList);
    } on RangeError {
      state = null;
    } on Error {
      rethrow;
    }
  }
}
