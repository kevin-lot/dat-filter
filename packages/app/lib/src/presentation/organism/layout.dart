import 'package:app/src/infra/provider/input_files_state.dart';
import 'package:app/src/infra/provider/output_path_state.dart';
import 'package:app/src/presentation/molecule/input_files_picker.dart';
import 'package:app/src/presentation/molecule/list_files.dart';
import 'package:app/src/presentation/molecule/output_path_picker.dart';
import 'package:app/src/presentation/molecule/tabs_panel.dart';
import 'package:app/src/presentation/organism/process_panel.dart';
import 'package:dimension/dimension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class Layout extends WatchingStatefulWidget {
  const Layout({
    super.key,
  });

  @override
  State<Layout> createState() => _Layout();
}

class _Layout extends State<Layout> with SingleTickerProviderStateMixin {
  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);
    final FilePickerResult? filePickerResult = watchPropertyValue((final FilePickerResultNotifier s) => s.value);
    final String? outputPath = watchPropertyValue((final OutputPathNotifier s) => s.value);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Spaces.primary),
        child: Stack(
          children: <Widget>[
            const Positioned(
              bottom: 0,
              left: 0,
              top: 0,
              width: MagicSpaces.panelWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                spacing: Spaces.primary,
                children: <Widget>[
                  PickOutputPath(),
                  Flexible(child: ListFiles()),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InputFilesPicker(),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              left: MagicSpaces.panelWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: Spaces.primary,
                children: <Widget>[
                  const Flexible(
                    child: TabsPanel(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _getOnPressedButtonFunction(filePickerResult, outputPath),
                      child: Text(appLocalizations.go),
                    ),
                  ),
                ],
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
    if (filePickerResult != null && filePickerResult.count > 0 && outputPath != null) {
      return () async => await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (final BuildContext context) => const ProcessPanel(),
          );
    }

    return null;
  }
}
