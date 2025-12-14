import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:riverpod/riverpod.dart';

abstract interface class XmlServiceFilterNotifierInterface extends AsyncNotifier<Map<PlatformFile, Datafile>?> {
  Map<PlatformFile, Datafile>? get value;

  Future<void> filter();

  void reset();
}
