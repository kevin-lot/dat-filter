import 'package:app/src/domain/item_selector_interface.dart';
import 'package:collection/collection.dart';

class ItemSelectorService<T extends ItemSelectorInterface<T>> {
  const ItemSelectorService(this.defaultList);

  final List<T> defaultList;

  List<T> get selected => defaultList.where((final T el) => el.isSelected).toList();

  List<T> autoSort() {
    return defaultList.sorted((final T el1, final T el2) {
      if (el1.isSelected == el2.isSelected) return 0;
      if (el1.isSelected && !el2.isSelected) return -1;
      return 1;
    });
  }

  List<T> build(final List<String> configurations) {
    final List<T> startList = defaultList
        .where((final T el) => configurations.contains(el.code))
        .map((final T el) => el.setSelected(true))
        .toList();
    final List<T> endList = defaultList.whereNot((final T el) => configurations.contains(el.code)).toList();

    return <T>[...startList, ...endList];
  }

  List<T> reorder(
    final int oldIndex,
    final int newIndex,
  ) {
    final newList = <T>[...defaultList];
    final int futureIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    final T region = newList.removeAt(oldIndex);
    newList.insert(futureIndex, region);

    return newList;
  }

  List<T> selectAll() {
    return defaultList.map((final T el) => el.setSelected(true)).toList();
  }

  List<T> toggleSelected(final int index) {
    final newList = <T>[...defaultList];
    newList[index] = newList[index].toggleSelected();

    return newList;
  }

  List<T> unselectAll() {
    return defaultList.map((final T el) => el.setSelected(false)).toList();
  }
}
