import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract class RegionsFirstMatchNotifierInterface extends ChangeNotifier {
  bool get value;

  void toggle();
}
