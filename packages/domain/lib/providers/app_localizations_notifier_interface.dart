import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:riverpod/riverpod.dart';

abstract interface class AppLocalizationsNotifierInterface extends Notifier<AppLocalizationsInterface> {
  AppLocalizationsInterface get value;
}
