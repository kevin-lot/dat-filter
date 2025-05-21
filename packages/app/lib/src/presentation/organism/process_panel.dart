import 'package:app/src/domain/model/datafile.dart';
import 'package:app/src/infra/provider/xml_service_state.dart';
import 'package:app/src/presentation/atom/list_tile_container.dart';
import 'package:dimension/dimension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class ProcessPanel extends WatchingWidget {
  const ProcessPanel({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier m) => m.value);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(Spaces.primary),
        child: Column(
          children: <Widget>[
            Text(
              appLocalizations.summary,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Spaces.primary),
            ListTile(
              title: ListTileContainer(
                first: const SizedBox.shrink(),
                second: Text(
                  appLocalizations.selected,
                  style: const TextStyle(decoration: TextDecoration.underline),
                  textAlign: TextAlign.right,
                ),
                third: Text(
                  appLocalizations.total,
                  style: const TextStyle(decoration: TextDecoration.underline),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const Expanded(child: _ListView()),
            const SizedBox(height: Spaces.primary),
            const _Buttons(),
          ],
        ),
      ),
    );
  }
}

class _ListView extends WatchingWidget {
  const _ListView();

  @override
  Widget build(final BuildContext context) {
    callOnce((final context) async {
      await di<XmlServiceFilterNotifier>().filter();
    });
    onDispose(() {
      di<XmlServiceFilterNotifier>().reset();
    });

    final Map<PlatformFile, Datafile>? map = watchPropertyValue((final XmlServiceFilterNotifier m) => m.value);
    if (map == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary.withValues(alpha: 0.15);
    final Color oddItemColor = colorScheme.primary.withValues(alpha: 0.05);

    return ListView.builder(
      itemCount: map.length,
      itemBuilder: (final BuildContext context, final int index) {
        return Material(
          child: ListTile(
            title: ListTileContainer(
              first: Text(map.keys.elementAt(index).name, overflow: TextOverflow.fade, maxLines: 3),
              second: Text(
                map.values.elementAt(index).gamesByName.totalLength.toString(),
                textAlign: TextAlign.right,
              ),
              third: Text(
                map.values.elementAt(index).originalGamesCount.toString(),
                textAlign: TextAlign.right,
              ),
            ),
            tileColor: index.isEven ? oddItemColor : evenItemColor,
          ),
        );
      },
    );
  }
}

class _Buttons extends WatchingWidget {
  const _Buttons();

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier m) => m.value);
    final Map<PlatformFile, Datafile>? map = watchPropertyValue((final XmlServiceFilterNotifier m) => m.value);
    final bool isSaving = watchPropertyValue((final XmlServiceSaveNotifier m) => m.isSaving);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: Spaces.primary,
      children: <ElevatedButton>[
        ElevatedButton(
          onPressed: isSaving
              ? null
              : () {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
          child: Text(appLocalizations.cancel),
        ),
        ElevatedButton(
          onPressed: map == null
              ? null
              : () async {
                  await di<XmlServiceSaveNotifier>().save();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
          child: isSaving
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
              : Text(appLocalizations.process),
        ),
      ],
    );
  }
}
