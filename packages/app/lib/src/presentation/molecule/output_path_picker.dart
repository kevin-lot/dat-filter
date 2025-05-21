import 'package:app/src/infra/provider/output_path_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class PickOutputPath extends WatchingStatefulWidget {
  const PickOutputPath({super.key});

  @override
  State<PickOutputPath> createState() => _PickOutputPath();
}

class _PickOutputPath extends State<PickOutputPath> {
  final TextEditingController _textEditController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);
    final String? lastPath = watchPropertyValue((final OutputPathNotifier s) => s.value);

    return TextField(
      controller: _textEditController,
      decoration: InputDecoration(
        label: Text(appLocalizations.outputDir),
        border: const OutlineInputBorder(),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Tooltip(
            message: appLocalizations.pickOutputDir,
            child: IconButton(
              icon: const Icon(Icons.folder),
              onPressed: () async => await _selectFolder(appLocalizations.pickOutputDir, lastPath),
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

      di<OutputPathNotifier>().set(path);
      setState(() {
        _textEditController.text = path;
      });
    } on PlatformException {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    } finally {
      // setState(() => _isLoading = false);
    }
  }
}
