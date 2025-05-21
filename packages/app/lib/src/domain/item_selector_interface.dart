abstract class ItemSelectorInterface<T> {
  String get code;

  String get displayCode;

  bool get isEmphasis;

  bool get isSelected;

  // ignore:avoid_positional_boolean_parameters
  T setSelected(final bool isSelected);

  T toggleSelected();
}
