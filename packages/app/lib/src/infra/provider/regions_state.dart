import 'package:app/src/domain/item_selector_service.dart';
import 'package:app/src/domain/model/region.dart';
import 'package:flutter/foundation.dart';
import 'package:infra/infra_repositories.dart';

extension BoolExtension on bool {
  TypeOfMatchRegionEnum toEnum() {
    return this ? TypeOfMatchRegionEnum.firstMatch : TypeOfMatchRegionEnum.allMatch;
  }
}

class RegionsNotifier extends ChangeNotifier {
  RegionsNotifier(final Preferences preferences)
      : value = preferences.configRegions == null
            ? allRegions
            : const ItemSelectorService<Region>(allRegions).build(preferences.configRegions!);

  List<Region> value;

  List<Region> get _copyValue => [...value];

  List<Region> get selected => (_copyValue..removeWhere((final Region el) => !el.isSelected));

  /// Keep the selected items on top
  void autoSort() {
    value = ItemSelectorService<Region>(_copyValue).autoSort();
    notifyListeners();
  }

  void reorder(final int oldIndex, final int newIndex) {
    value = ItemSelectorService<Region>(_copyValue).reorder(oldIndex, newIndex);
    notifyListeners();
  }

  void selectAll() {
    value = ItemSelectorService<Region>(_copyValue).selectAll();
    notifyListeners();
  }

  void toggleSelected(final int index) {
    value = ItemSelectorService<Region>(_copyValue).toggleSelected(index);
    notifyListeners();
  }

  void unselectAll() {
    value = ItemSelectorService<Region>(_copyValue).unselectAll();
    notifyListeners();
  }
}

class RegionsFirstMatchNotifier extends ChangeNotifier {
  RegionsFirstMatchNotifier(final Preferences preferences) : value = preferences.configRegionsFirstMatch ?? false;

  bool value;

  void toggle() {
    value = !value;
    notifyListeners();
  }
}
