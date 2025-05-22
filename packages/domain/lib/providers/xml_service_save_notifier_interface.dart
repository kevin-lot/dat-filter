import 'dart:async';

import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class XmlServiceSaveNotifierInterface extends ChangeNotifier {
  bool get isSaving;

  Future<void> save();
}
