import 'package:app/feature/usecase/item_selector_service.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension BoolExtension on bool {
  TypeOfMatchRegionEnum toEnum() {
    return this ? TypeOfMatchRegionEnum.firstMatch : TypeOfMatchRegionEnum.allMatch;
  }
}

class RegionsNotifier extends Notifier<List<Region>> implements RegionsNotifierInterface {
  RegionsNotifier(this._preferences);

  final Preferences _preferences;

  @override
  List<Region> get value => state;

  List<Region> get _copyValue => [...value];

  @override
  List<Region> get selected => (_copyValue..removeWhere((final Region el) => !el.isSelected));

  @override
  List<Region> build() {
    state = _preferences.configRegions == null
        ? allRegions
        : const ItemSelectorService<Region>(allRegions).build(_preferences.configRegions!);
    return state;
  }

  /// Keep the selected items on top
  @override
  void autoSort() {
    state = ItemSelectorService<Region>(_copyValue).autoSort();
  }

  @override
  void reorder(final int oldIndex, final int newIndex) {
    state = ItemSelectorService<Region>(_copyValue).reorder(oldIndex, newIndex);
  }

  @override
  void selectAll() {
    state = ItemSelectorService<Region>(_copyValue).selectAll();
  }

  @override
  void toggleSelected(final int index) {
    state = ItemSelectorService<Region>(_copyValue).toggleSelected(index);
  }

  @override
  void unselectAll() {
    state = ItemSelectorService<Region>(_copyValue).unselectAll();
  }
}

class RegionsFirstMatchNotifier extends Notifier<bool> implements RegionsFirstMatchNotifierInterface {
  RegionsFirstMatchNotifier(this._preferences);

  final Preferences _preferences;

  @override
  bool get value => state;

  @override
  bool build() {
    state = _preferences.configRegionsFirstMatch ?? false;
    return state;
  }

  @override
  void toggle() {
    state = !state;
  }
}
