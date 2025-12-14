import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';

abstract interface class XmlServiceSaveNotifierInterface extends AsyncNotifier<File?> {
  Future<void> save();
}
