import 'package:app/service_locator.dart';
import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:yaru/widgets.dart';

class OutputPathPicker extends ConsumerStatefulWidget {
  const OutputPathPicker({super.key});

  @override
  ConsumerState<OutputPathPicker> createState() => _State();
}

class _State extends ConsumerState<OutputPathPicker> {
  final Logger _logger = Logger((_State).toString());
  final TextEditingController _textEditController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface? appLocalizations = ref.watch(appLocalizationsNotifierProvider).value?.value;
    final String? outputPath = ref.watch(outputPathNotifierProvider).value;

    if (appLocalizations == null || outputPath == null) {
      return const SizedBox();
    }

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

  Future<void> _selectFolder(final String windowTitle, final String? lastPath, final WidgetRef ref) async {
    try {
      final String? path = await FilePicker.platform.getDirectoryPath(
        dialogTitle: windowTitle,
        initialDirectory: lastPath,
        lockParentWindow: true,
      );

      if (path == null) {
        return;
      }

      ref.read(outputPathNotifierProvider).set(path);

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
