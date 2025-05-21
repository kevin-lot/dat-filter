import 'package:app/src/domain/item_selector_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.freezed.dart';

enum TypeOfMatchRegionEnum {
  firstMatch,
  allMatch,
}

extension ListRegionExtension on List<Region> {
  List<String> get codes => map((final Region el) => el.code).toList();

  List<Region> get selected => where((final Region region) => region.isSelected).toList();
}

extension ListStringExtension on List<String> {
  bool hasRegions(final List<Region> regionsToFilter) {
    final Set<String> codesToFilter = regionsToFilter.selected.codes.toSet();
    return toSet().intersection(codesToFilter).isNotEmpty;
  }
}

const allRegions = <Region>[
  Region(code: 'AUS', isSelected: false),
  Region(code: 'bz', isSelected: false),
  Region(code: 'CAN', isSelected: false),
  Region(code: 'ch', isSelected: false),
  Region(code: 'en', isSelected: false),
  Region(code: 'FRA', isSelected: false),
  Region(code: 'GER', isSelected: false),
  Region(code: 'hk', isSelected: false),
  Region(code: 'ITA', isSelected: false),
  Region(code: 'JPN', isSelected: false),
  Region(code: 'KOR', isSelected: false),
  Region(code: 'nh', isSelected: false),
  Region(code: 'SPA', isSelected: false),
  Region(code: 'sw', isSelected: false),
  Region(code: 'TAI', isSelected: false),
  Region(code: 'USA', isSelected: false),
  Region(code: 'as', isSelected: false, isEmphasis: true),
  Region(code: 'EUR', isSelected: false, isEmphasis: true),
  Region(code: 'jp-eu', isSelected: false, isEmphasis: true),
  Region(code: 'jp-us', isSelected: false, isEmphasis: true),
  Region(code: 'us-eu', isSelected: false, isEmphasis: true),
  Region(code: 'w', isSelected: false, isEmphasis: true),
];

@freezed
abstract class Region with _$Region implements ItemSelectorInterface<Region> {
  const factory Region({
    required final String code,
    required final bool isSelected,
    @Default(false) final bool isEmphasis,
  }) = _Region;

  /// Used for implementing our own methods
  const Region._();

  @override
  String get displayCode => 'region_${code.replaceAll('-', '_')}';

  @override
  // ignore:avoid_positional_boolean_parameters
  Region setSelected(final bool isSelected) => copyWith(isSelected: isSelected);

  @override
  Region toggleSelected() => copyWith(isSelected: !isSelected);
}
