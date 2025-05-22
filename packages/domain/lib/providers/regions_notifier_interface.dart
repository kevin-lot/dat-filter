import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

abstract interface class RegionsNotifierInterface extends ChangeNotifier {
  List<Region> get value;

  List<Region> get selected;

  /// Keep the selected items on top
  void autoSort();

  void reorder(final int oldIndex, final int newIndex);

  void selectAll();

  void toggleSelected(final int index);

  void unselectAll();
}
