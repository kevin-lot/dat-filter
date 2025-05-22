import 'package:domain/domain.dart'
    show AppLocalizationsInterface, AppLocalizationsNotifierInterface, OutputPathNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/widgets.dart';

class OutputPathPicker extends WatchingStatefulWidget {
  const OutputPathPicker({super.key});

  @override
  State<OutputPathPicker> createState() => _State();
}

class _State extends State<OutputPathPicker> {
  final Logger _logger = Logger((_State).toString());
  final TextEditingController _textEditController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface n) => n.value);
    final String? outputPath = watchPropertyValue((final OutputPathNotifierInterface n) => n.value);

    return TextField(
      controller: _textEditController,
      decoration: InputDecoration(
        label: Text(appLocalizations.outputDir),
        border: const OutlineInputBorder(),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Tooltip(
            message: appLocalizations.pickOutputDir,
            child: YaruIconButton(
              icon: const Icon(Icons.folder),
              onPressed: () async => await _selectFolder(appLocalizations.pickOutputDir, outputPath),
            ),
          ),
        ),
      ),
      readOnly: true,
    );
  }

  Future<void> _selectFolder(final String windowTitle, final String? lastPath) async {
    try {
      final String? path = await FilePicker.platform.getDirectoryPath(
        dialogTitle: windowTitle,
        initialDirectory: lastPath,
        lockParentWindow: true,
      );

      if (path == null) {
        return;
      }

      di<OutputPathNotifierInterface>().set(path);
      setState(() {
        _textEditController.text = path;
      });
    } on PlatformException {
      _logger.fine('Unsupported operation');
    } on Exception catch (e) {
      _logger.fine(e.toString());
    }
  }
}
