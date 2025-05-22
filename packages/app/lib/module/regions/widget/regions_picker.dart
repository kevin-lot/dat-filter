import 'package:app/module/regions/widget/select_multi_picker.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart'
    show
        AppLocalizationsInterface,
        AppLocalizationsNotifierInterface,
        Region,
        RegionsFirstMatchNotifierInterface,
        RegionsNotifierInterface;
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class RegionsPicker extends WatchingStatefulWidget {
  const RegionsPicker({super.key});

  @override
  State<RegionsPicker> createState() => _RegionsPicker();
}

class _RegionsPicker extends State<RegionsPicker> {
  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface n) => n.value);
    final List<Region> regions = watchPropertyValue((final RegionsNotifierInterface n) => n.value);
    final bool switchValue = watchPropertyValue((final RegionsFirstMatchNotifierInterface n) => n.value);

    return Column(
      children: <Widget>[
        YaruSwitchListTile(
          value: switchValue,
          onChanged: (final bool value) => di<RegionsFirstMatchNotifierInterface>().toggle(),
          title: Text(appLocalizations.configStopOnFirstMatch),
          subtitle: Text(
            switchValue
                ? appLocalizations.configStopOnFirstMatchDescription
                : appLocalizations.configNoStopOnFirstMatchDescription,
          ),
        ),
        const SizedBox(height: MagicSpaces.primary),
        Expanded(
          child: SelectMultiPicker<Region>(
            items: regions,
            onAutoSort: di<RegionsNotifierInterface>().autoSort,
            onReorder: di<RegionsNotifierInterface>().reorder,
            onSelectAll: di<RegionsNotifierInterface>().selectAll,
            onToggleSelected: di<RegionsNotifierInterface>().toggleSelected,
            onUnselectAll: di<RegionsNotifierInterface>().unselectAll,
          ),
        ),
      ],
    );
  }
}
