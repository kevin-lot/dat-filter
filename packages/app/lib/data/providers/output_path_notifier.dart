import 'package:domain/domain.dart' show OutputPathNotifierInterface;
import 'package:signals/signals_flutter.dart';

class OutputPathNotifier extends Signal<String?>
    with ValueNotifierSignalMixin<String?>
    implements OutputPathNotifierInterface {
  OutputPathNotifier() : super.lazy();

  @override
  void clear() {
    value = null;
    notifyListeners();
  }
}
