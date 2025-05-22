import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class RegionsFirstMatchNotifierInterface extends ChangeNotifier {
  bool get value;

  void toggle();
}
