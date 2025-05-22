import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart'
    show
        AppLocalizationsInterface,
        AppLocalizationsNotifierInterface,
        Datafile,
        GamesByNameExtension,
        XmlServiceFilterNotifierInterface,
        XmlServiceSaveNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class ProcessPanel extends WatchingWidget {
  const ProcessPanel({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface m) => m.value);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(MagicSpaces.primary),
        child: Column(
          children: <Widget>[
            Text(
              appLocalizations.summary,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: MagicSpaces.primary),
            ListTile(
              title: _ListTileContainer(
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
            const SizedBox(height: MagicSpaces.primary),
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
      await di<XmlServiceFilterNotifierInterface>().filter();
    });
    onDispose(() {
      di<XmlServiceFilterNotifierInterface>().reset();
    });

    final Map<PlatformFile, Datafile>? map = watchPropertyValue((final XmlServiceFilterNotifierInterface m) => m.value);
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
            title: _ListTileContainer(
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
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface m) => m.value);
    final Map<PlatformFile, Datafile>? map = watchPropertyValue((final XmlServiceFilterNotifierInterface m) => m.value);
    final bool isSaving = watchPropertyValue((final XmlServiceSaveNotifierInterface n) => n.isSaving);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: MagicSpaces.primary,
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
                  await di<XmlServiceSaveNotifierInterface>().save();
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

class _ListTileContainer extends StatelessWidget {
  const _ListTileContainer({
    required this.first,
    required this.second,
    required this.third,
  });

  final Widget first;
  final Widget second;
  final Widget third;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(flex: 4, child: first),
        Expanded(flex: 1, child: second),
        Expanded(flex: 1, child: third),
      ],
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Widget>('first', first))
      ..add(DiagnosticsProperty<Widget>('second', second))
      ..add(DiagnosticsProperty<Widget>('third', third));
  }
}
