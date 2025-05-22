import 'package:app/feature/usecase/path_service.dart';
import 'package:domain/domain.dart'
    show AppLocalizationsInterface, AppLocalizationsNotifierInterface, FilePickerResultNotifierInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:watch_it/watch_it.dart';

final Logger _logger = Logger('InputFilesPicker');

class InputFilesPicker extends WatchingWidget {
  const InputFilesPicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface n) => n.value);

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

      di<FilePickerResultNotifierInterface>().set(files);
    } on PlatformException {
      _logger.fine('Unsupported operation');
    } on Exception catch (e) {
      _logger.fine(e.toString());
    }
  }
}
