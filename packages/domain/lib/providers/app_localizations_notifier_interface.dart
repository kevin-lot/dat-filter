import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract class AppLocalizationsNotifierInterface extends ChangeNotifier {
  AppLocalizationsInterface get value;
}
