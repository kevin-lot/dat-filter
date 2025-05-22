import 'package:app/module/input_files/widget/input_files_picker.dart';
import 'package:app/module/input_files/widget/list_files.dart';
import 'package:app/module/output_path/widget/output_path_selector.dart';
import 'package:app/module/regions/widget/regions_picker.dart';
import 'package:app/module/settings/widget/settings.dart';
import 'package:app/presentation/process_panel.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart'
    show
        AppLocalizationsInterface,
        AppLocalizationsNotifierInterface,
        FilePickerResultNotifierInterface,
        OutputPathNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class Layout extends WatchingStatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _Layout();
}

class _Layout extends State<Layout> {
  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface n) => n.value);
    final FilePickerResult? filePickerResult =
        watchPropertyValue((final FilePickerResultNotifierInterface n) => n.value);
    final String? outputPath = watchPropertyValue((final OutputPathNotifierInterface n) => n.value);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(MagicSpaces.primary),
        child: Stack(
          children: <Widget>[
            Positioned(
              height: 40,
              left: 0,
              right: 0,
              top: 0,
              child: Row(
                children: <Widget>[
                  const InputFilesPicker(),
                  const SizedBox(width: MagicSpaces.primary),
                  const SizedBox(width: 264, child: OutputPathPicker()),
                  const SizedBox(width: MagicSpaces.primary),
                  ElevatedButton(
                    onPressed: _getOnPressedButtonFunction(filePickerResult, outputPath),
                    child: Text(appLocalizations.go),
                  ),
                  const Spacer(),
                  YaruIconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () async {
                      await showDialog(
                        builder: (final BuildContext context) {
                          return const Settings();
                        },
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              top: 50,
              width: MagicSpaces.panelWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                spacing: MagicSpaces.primary,
                children: <Widget>[
                  Flexible(child: ListFiles()),
                ],
              ),
            ),
            const Positioned.fill(
              top: 50,
              left: MagicSpaces.panelWidth + MagicSpaces.primary,
              child: YaruSection(
                child: RegionsPicker(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Return a function
  /// or null (in this case the button is disabled).
  VoidCallback? _getOnPressedButtonFunction(
    final FilePickerResult? filePickerResult,
    final String? outputPath,
  ) {
    if (filePickerResult == null || filePickerResult.count <= 0 || outputPath == null) {
      return null;
    }

    return () async => await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (final BuildContext context) {
            return const ProcessPanel();
          },
        );
  }
}
