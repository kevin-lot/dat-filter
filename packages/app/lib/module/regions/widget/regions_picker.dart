import 'package:app/feature/provider/regions_notifier.dart';
import 'package:app/module/regions/widget/select_multi_picker.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
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
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier n) => n.value);
    final List<Region> regions = watchPropertyValue((final RegionsNotifier n) => n.value);
    final bool switchValue = watchPropertyValue((final RegionsFirstMatchNotifier n) => n.value);

    return Column(
      children: <Widget>[
        YaruSwitchListTile(
          value: switchValue,
          onChanged: (final bool value) => di<RegionsFirstMatchNotifier>().toggle(),
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
            onAutoSort: di<RegionsNotifier>().autoSort,
            onReorder: di<RegionsNotifier>().reorder,
            onSelectAll: di<RegionsNotifier>().selectAll,
            onToggleSelected: di<RegionsNotifier>().toggleSelected,
            onUnselectAll: di<RegionsNotifier>().unselectAll,
          ),
        ),
      ],
    );
  }
}
