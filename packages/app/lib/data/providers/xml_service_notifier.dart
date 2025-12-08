import 'dart:async';

import 'package:app/data/providers/regions_notifier.dart';
import 'package:app/feature/usecase/xml_service.dart';
import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart';
import 'package:signals/signals_flutter.dart';

abstract class XmlServiceNotifier extends Signal<Map<PlatformFile, Datafile>?>
    with ValueNotifierSignalMixin<Map<PlatformFile, Datafile>?> {
  XmlServiceNotifier({
    required this.filePickerResultNotifier,
    required this.outputPathNotifier,
    required this.regionFirstMatchNotifier,
    required this.regionsNotifier,
  }) : super.lazy() {
    filePickerResult = computed(() => filePickerResultNotifier.value).value;
    regions = computed(() => regionsNotifier.value).value;
    outputPath = computed(() => outputPathNotifier.value).value;
    regionFirstMatch = computed(() => regionFirstMatchNotifier.value).value;
  }

  final FilePickerResultNotifierInterface filePickerResultNotifier;
  final OutputPathNotifierInterface outputPathNotifier;
  final RegionsFirstMatchNotifierInterface regionFirstMatchNotifier;
  final RegionsNotifierInterface regionsNotifier;

  FilePickerResult? filePickerResult;
  List<Region>? regions;
  String? outputPath;
  bool? regionFirstMatch;
}

class XmlServiceFilterNotifier extends XmlServiceNotifier implements XmlServiceFilterNotifierInterface {
  XmlServiceFilterNotifier({
    required super.filePickerResultNotifier,
    required super.outputPathNotifier,
    required super.regionFirstMatchNotifier,
    required super.regionsNotifier,
  });

  @override
  FlutterSignal<bool> isFiltering = signal(false);

  @override
  Future<void> filter() async {
    isFiltering.value = true;

    if (filePickerResult == null || regions == null || outputPath == null || regionFirstMatch == null) {
      throw Exception(
        'XmlService: missing requirements to filter (filePickerResult: $filePickerResult, regions: $regions, outputPath: $outputPath, regionFirstMatch: $regionFirstMatch)',
      );
    }

    value = await XmlService(
      filePickerResult: filePickerResult!,
      outputPath: outputPath!,
      regionsToFilter: regions!,
      typeOfMatch: regionFirstMatch!.toEnum(),
    ).filter();

    isFiltering.value = false;
  }
}

class XmlServiceSaveNotifier extends XmlServiceNotifier implements XmlServiceSaveNotifierInterface {
  XmlServiceSaveNotifier({
    required super.filePickerResultNotifier,
    required super.outputPathNotifier,
    required super.regionFirstMatchNotifier,
    required super.regionsNotifier,
  });

  @override
  FlutterSignal<bool> isSaving = signal(false);

  @override
  Future<void> save() async {
    isSaving.value = true;

    if (filePickerResult == null || regions == null || outputPath == null || regionFirstMatch == null) {
      throw Exception(
        'XmlService: missing requirements to save (filePickerResult: $filePickerResult, regions: $regions, outputPath: $outputPath, regionFirstMatch: $regionFirstMatch)',
      );
    }

    await XmlService(
      filePickerResult: filePickerResult!,
      outputPath: outputPath!,
      regionsToFilter: regions!,
      typeOfMatch: regionFirstMatch!.toEnum(),
    ).save();

    isSaving.value = false;
  }
}
