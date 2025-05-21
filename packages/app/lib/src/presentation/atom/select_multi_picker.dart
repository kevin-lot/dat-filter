import 'package:app/src/domain/item_selector_interface.dart';
import 'package:app/src/domain/item_selector_service.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class SelectMultiPicker<T extends ItemSelectorInterface<T>> extends WatchingStatefulWidget {
  const SelectMultiPicker({
    required this.items,
    required this.onAutoSort,
    required this.onReorder,
    required this.onSelectAll,
    required this.onToggleSelected,
    required this.onUnselectAll,
    super.key,
  });

  final List<T> items;
  final VoidCallback onAutoSort;
  final void Function(int, int) onReorder;
  final VoidCallback onSelectAll;
  final ValueChanged<int> onToggleSelected;
  final VoidCallback onUnselectAll;

  @override
  State<SelectMultiPicker<T>> createState() => _ConfigSelector<T>();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<List<T>>('items', items))
      ..add(DiagnosticsProperty<VoidCallback>('onAutoSort', onAutoSort))
      ..add(DiagnosticsProperty<void Function(int, int)>('onReorder', onReorder))
      ..add(DiagnosticsProperty<VoidCallback>('onSelectAll', onSelectAll))
      ..add(DiagnosticsProperty<ValueChanged<int>>('onToggleSelected', onToggleSelected))
      ..add(DiagnosticsProperty<VoidCallback>('onUnselectAll', onUnselectAll));
  }
}

class _ConfigSelector<T extends ItemSelectorInterface<T>> extends State<SelectMultiPicker<T>> {
  late bool? _allSelected;

  @override
  void initState() {
    super.initState();
    _allSelected = _getAllSelect();
  }

  @override
  void didUpdateWidget(final SelectMultiPicker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      setState(() => _allSelected = _getAllSelect());
    }
  }

  @override
  Widget build(final BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);

    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: Spaces.primary),
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (final bool? value) {
                  if (value ?? false) {
                    widget.onSelectAll();
                    setState(() => _allSelected = _getAllSelect());
                    return;
                  }
                  widget.onUnselectAll();
                  setState(() => _allSelected = _getAllSelect());
                },
                tristate: true,
                value: _allSelected,
              ),
              const SizedBox(width: 2),
              Text(_getListStatus(widget.items)),
              const Spacer(),
              Tooltip(
                message: appLocalizations.sortSelection,
                child: IconButton(
                  onPressed: () {
                    widget.onAutoSort();
                  },
                  icon: const Icon(Icons.format_line_spacing),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              for (int index = 0; index < widget.items.length; index++)
                Material(
                  key: ValueKey<String>(widget.items[index].code),
                  child: ListTile(
                    leading: Checkbox(
                      value: widget.items[index].isSelected,
                      onChanged: (final bool? value) {
                        if (value == null) {
                          return;
                        }
                        widget.onToggleSelected(index);
                        setState(() => _allSelected = _getAllSelect());
                      },
                    ),
                    title: Text(
                      appLocalizations.getTranslatedRegion(widget.items[index].displayCode),
                      style: TextStyle(fontStyle: widget.items[index].isEmphasis ? FontStyle.italic : FontStyle.normal),
                    ),
                    tileColor: index.isEven ? oddItemColor : evenItemColor,
                  ),
                ),
            ],
            onReorder: (final int oldIndex, final int newIndex) {
              widget.onReorder(oldIndex, newIndex);
            },
          ),
        ),
      ],
    );
  }

  bool? _getAllSelect() {
    final List<T> selected = <T>[...widget.items]..removeWhere((final T el) => !el.isSelected);

    if (selected.length == widget.items.length) return true;
    if (selected.isEmpty) return false;
    return null;
  }

  String _getListStatus(final List<T> items) {
    final int selectCount = ItemSelectorService<T>(items).selected.length;

    return '($selectCount / ${items.length})';
  }
}
