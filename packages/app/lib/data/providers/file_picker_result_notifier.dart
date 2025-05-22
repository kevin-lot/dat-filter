import 'package:domain/domain.dart' show FilePickerResultNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class FilePickerResultNotifier extends SafeChangeNotifier implements FilePickerResultNotifierInterface {
  @override
  FilePickerResult? value;

  @override
  void set(final FilePickerResult newValue) {
    if (newValue == value) return;
    value = newValue;
    notifyListeners();
  }

  @override
  void removeAt(final int index) {
    if (value == null) return;

    try {
      final List<PlatformFile> newList = [...value!.files]..removeAt(index); // prevent reference
      value = FilePickerResult(newList);
      notifyListeners();
    } on RangeError {
      notifyListeners();
    } on Error {
      rethrow;
    }
  }
}
