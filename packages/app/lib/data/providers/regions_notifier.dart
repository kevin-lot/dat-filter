import 'package:app/feature/usecase/item_selector_service.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';

extension BoolExtension on bool {
  TypeOfMatchRegionEnum toEnum() {
    return this ? TypeOfMatchRegionEnum.firstMatch : TypeOfMatchRegionEnum.allMatch;
  }
}

class RegionsNotifier extends ChangeNotifier implements RegionsNotifierInterface {
  RegionsNotifier(final Preferences preferences)
      : value = preferences.configRegions == null
            ? allRegions
            : const ItemSelectorService<Region>(allRegions).build(preferences.configRegions!);

  @override
  List<Region> value;

  List<Region> get _copyValue => [...value];

  @override
  List<Region> get selected => (_copyValue..removeWhere((final Region el) => !el.isSelected));

  /// Keep the selected items on top
  @override
  void autoSort() {
    value = ItemSelectorService<Region>(_copyValue).autoSort();
    notifyListeners();
  }

  @override
  void reorder(final int oldIndex, final int newIndex) {
    value = ItemSelectorService<Region>(_copyValue).reorder(oldIndex, newIndex);
    notifyListeners();
  }

  @override
  void selectAll() {
    value = ItemSelectorService<Region>(_copyValue).selectAll();
    notifyListeners();
  }

  @override
  void toggleSelected(final int index) {
    value = ItemSelectorService<Region>(_copyValue).toggleSelected(index);
    notifyListeners();
  }

  @override
  void unselectAll() {
    value = ItemSelectorService<Region>(_copyValue).unselectAll();
    notifyListeners();
  }
}

class RegionsFirstMatchNotifier extends ChangeNotifier implements RegionsFirstMatchNotifierInterface {
  RegionsFirstMatchNotifier(final Preferences preferences) : value = preferences.configRegionsFirstMatch ?? false;

  @override
  bool value;

  @override
  void toggle() {
    value = !value;
    notifyListeners();
  }
}
