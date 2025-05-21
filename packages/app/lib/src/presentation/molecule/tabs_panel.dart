import 'package:app/src/presentation/molecule/config_regions_picker.dart';
import 'package:app/src/presentation/molecule/settings.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class TabsPanel extends WatchingStatefulWidget {
  const TabsPanel({super.key});

  @override
  State<TabsPanel> createState() => _TabsPanel();
}

class _TabsPanel extends State<TabsPanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = di<AppLocalizationsNotifier>().value;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(child: Text(appLocalizations.configRegions)),
              const Tab(icon: Icon(Icons.settings)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                ConfigRegionsPicker(),
                Settings(),
              ].map((final Widget el) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Spaces.primary),
                    constraints: const BoxConstraints(maxWidth: MagicSpaces.panelWidth),
                    child: el,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
