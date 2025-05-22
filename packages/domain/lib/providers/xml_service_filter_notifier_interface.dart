import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract class XmlServiceFilterNotifierInterface extends ChangeNotifier {
  bool get isFiltering;

  Map<PlatformFile, Datafile>? get value;

  Future<void> filter();

  void reset();
}
