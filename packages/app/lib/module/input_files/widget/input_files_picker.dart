import 'package:app/feature/usecase/path_service.dart';
import 'package:app/service_locator.dart';
import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('InputFilesPicker');

class InputFilesPicker extends ConsumerWidget {
  const InputFilesPicker({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final AppLocalizationsInterface? appLocalizations = ref.watch(appLocalizationsNotifierProvider).value?.value;

    if (appLocalizations == null) {
      return const SizedBox();
    }

    return ElevatedButton.icon(
      icon: const Icon(Icons.file_open),
      onPressed: () async => await _pickFiles(appLocalizations.pickInputFiles, ref),
      label: Text(appLocalizations.pickInputFiles),
    );
  }

  Future<void> _pickFiles(final String windowTitle, final WidgetRef ref) async {
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

      ref.read(filePickerResultNotifierProvider).set(files);
    } on PlatformException {
      _logger.fine('Unsupported operation');
    } on Exception catch (e) {
      _logger.fine(e.toString());
    }
  }
}
