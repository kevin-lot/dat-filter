import 'package:file_picker/file_picker.dart' show FilePickerResult;
import 'package:riverpod/riverpod.dart';

abstract interface class FilePickerResultNotifierInterface extends Notifier<FilePickerResult?> {
  FilePickerResult? get value;

  void set(final FilePickerResult newValue);

  void removeAt(final int index);
}
