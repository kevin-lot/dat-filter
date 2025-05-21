import 'package:app/src/infra/path_service.dart';
import 'package:app/src/infra/provider/input_files_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

class InputFilesPicker extends WatchingWidget {
  const InputFilesPicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);

    return ElevatedButton.icon(
      icon: const Icon(Icons.file_open),
      onPressed: () async => await _pickFiles(appLocalizations.pickInputFiles),
      label: Text(appLocalizations.pickInputFiles),
    );
  }

  Future<void> _pickFiles(final String windowTitle) async {
    try {
      final FilePickerResult? files = await FilePicker.platform.pickFiles(
        // allowedExtensions: (_extension?.isNotEmpty ?? false) ? _extension?.replaceAll(' ', '').split(',') : null,
        // onFileLoading: (FilePickerStatus status) => print(status),
        allowMultiple: true,
        dialogTitle: windowTitle,
        initialDirectory: await homeDirectory,
        lockParentWindow: true,
        type: FileType.any,
      );

      if (files == null) {
        return;
      }

      di<FilePickerResultNotifier>().set(files);
    } on PlatformException {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    }
  }
}
