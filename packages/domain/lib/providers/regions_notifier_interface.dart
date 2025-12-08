import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:signals/signals_flutter.dart';

abstract interface class RegionsNotifierInterface
    implements ValueNotifier<List<Region>>, FlutterReadonlySignal<List<Region>> {
  List<Region> get selected;

  /// Keep the selected items on top
  void autoSort();

  void reorder(final int oldIndex, final int newIndex);

  void selectAll();

  void toggleSelected(final int index);

  void unselectAll();
}
