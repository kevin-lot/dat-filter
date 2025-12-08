import 'package:domain/domain.dart' show FilePickerResultNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:signals/signals_flutter.dart';

class FilePickerResultNotifier extends Signal<FilePickerResult?>
    with ValueNotifierSignalMixin<FilePickerResult?>
    implements FilePickerResultNotifierInterface {
  FilePickerResultNotifier() : super.lazy();

  @override
  void removeAt(final int index) {
    if (value == null) return;

    try {
      final List<PlatformFile> newList = [...value!.files]..removeAt(index); // prevent reference
      value = FilePickerResult(newList);
    } on RangeError {
      // TODO notifyListeners();
    } on Error {
      rethrow;
    }
  }
}
