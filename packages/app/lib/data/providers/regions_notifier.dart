import 'package:app/feature/usecase/item_selector_service.dart';
import 'package:domain/domain.dart';
import 'package:signals/signals_flutter.dart';

extension BoolExtension on bool {
  TypeOfMatchRegionEnum toEnum() {
    return this ? TypeOfMatchRegionEnum.firstMatch : TypeOfMatchRegionEnum.allMatch;
  }
}

class RegionsNotifier extends Signal<List<Region>>
    with ValueNotifierSignalMixin<List<Region>>
    implements RegionsNotifierInterface {
  RegionsNotifier(final Preferences preferences)
      : super(
          preferences.configRegions == null
              ? allRegions
              : const ItemSelectorService<Region>(allRegions).build(preferences.configRegions!),
        );

  List<Region> get _copyValue => [...value];

  @override
  List<Region> get selected => (_copyValue..removeWhere((final Region el) => !el.isSelected));

  /// Keep the selected items on top
  @override
  void autoSort() {
    value = ItemSelectorService<Region>(_copyValue).autoSort();
  }

  @override
  void reorder(final int oldIndex, final int newIndex) {
    value = ItemSelectorService<Region>(_copyValue).reorder(oldIndex, newIndex);
  }

  @override
  void selectAll() {
    value = ItemSelectorService<Region>(_copyValue).selectAll();
  }

  @override
  void toggleSelected(final int index) {
    value = ItemSelectorService<Region>(_copyValue).toggleSelected(index);
  }

  @override
  void unselectAll() {
    value = ItemSelectorService<Region>(_copyValue).unselectAll();
  }
}

class RegionsFirstMatchNotifier extends Signal<bool>
    with ValueNotifierSignalMixin<bool>
    implements RegionsFirstMatchNotifierInterface {
  RegionsFirstMatchNotifier(final Preferences preferences) : super(preferences.configRegionsFirstMatch ?? false);

  @override
  void toggle({
    /// Skip equality check and update the value
    final bool force = false,
  }) {
    set(!value, force: force);
  }
}
