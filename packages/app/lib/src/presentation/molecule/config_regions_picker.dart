import 'package:app/src/domain/model/region.dart';
import 'package:app/src/infra/provider/regions_state.dart';
import 'package:app/src/presentation/atom/select_multi_picker.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class ConfigRegionsPicker extends WatchingStatefulWidget {
  const ConfigRegionsPicker({super.key});

  @override
  State<ConfigRegionsPicker> createState() => _ConfigRegionsPicker();
}

class _ConfigRegionsPicker extends State<ConfigRegionsPicker> {
  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);
    final List<Region> regions = watchPropertyValue((final RegionsNotifier s) => s.value);
    final bool switchValue = watchPropertyValue((final RegionsFirstMatchNotifier s) => s.value);

    return Column(
      children: <Widget>[
        Expanded(
          child: SelectMultiPicker<Region>(
            items: regions,
            onAutoSort: di<RegionsNotifier>().autoSort,
            onReorder: di<RegionsNotifier>().reorder,
            onSelectAll: di<RegionsNotifier>().selectAll,
            onToggleSelected: di<RegionsNotifier>().toggleSelected,
            onUnselectAll: di<RegionsNotifier>().unselectAll,
          ),
        ),
        const SizedBox(height: Spaces.primary),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(appLocalizations.configStopOnFirstMatch),
            Switch(
              value: switchValue,
              onChanged: (final bool value) => di<RegionsFirstMatchNotifier>().toggle(),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switchValue
                ? appLocalizations.configStopOnFirstMatchDescription
                : appLocalizations.configNoStopOnFirstMatchDescription,
          ),
        ),
      ],
    );
  }
}
