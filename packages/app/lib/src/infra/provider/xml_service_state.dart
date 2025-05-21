import 'dart:async';

import 'package:app/src/domain/model/datafile.dart';
import 'package:app/src/domain/model/region.dart';
import 'package:app/src/domain/xml_service.dart';
import 'package:app/src/infra/provider/input_files_state.dart';
import 'package:app/src/infra/provider/output_path_state.dart';
import 'package:app/src/infra/provider/regions_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

abstract class XmlServiceNotifier extends ChangeNotifier {
  XmlServiceNotifier({
    required this.filePickerResultNotifier,
    required this.outputPathNotifier,
    required this.regionFirstMatchNotifier,
    required this.regionsNotifier,
  }) {
    filePickerResultNotifier.addListener(_onDependencyChanged);
    outputPathNotifier.addListener(_onDependencyChanged);
    regionFirstMatchNotifier.addListener(_onDependencyChanged);
    regionsNotifier.addListener(_onDependencyChanged);
  }

  final FilePickerResultNotifier filePickerResultNotifier;
  final OutputPathNotifier outputPathNotifier;
  final RegionsFirstMatchNotifier regionFirstMatchNotifier;
  final RegionsNotifier regionsNotifier;

  FilePickerResult? filePickerResult;
  List<Region>? regions;
  String? outputPath;
  bool? regionFirstMatch;

  @override
  void dispose() {
    filePickerResultNotifier.removeListener(_onDependencyChanged);
    outputPathNotifier.removeListener(_onDependencyChanged);
    regionFirstMatchNotifier.removeListener(_onDependencyChanged);
    regionsNotifier.removeListener(_onDependencyChanged);
    super.dispose();
  }

  Future<void> _onDependencyChanged() async {
    if (filePickerResultNotifier.value != null) filePickerResult = filePickerResultNotifier.value;
    regions = regionsNotifier.value;
    if (outputPathNotifier.value != null) outputPath = outputPathNotifier.value;
    regionFirstMatch = regionFirstMatchNotifier.value;

    notifyListeners();
  }
}

class XmlServiceFilterNotifier extends XmlServiceNotifier {
  XmlServiceFilterNotifier({
    required super.filePickerResultNotifier,
    required super.outputPathNotifier,
    required super.regionFirstMatchNotifier,
    required super.regionsNotifier,
  });

  bool isFiltering = false;
  Map<PlatformFile, Datafile>? value;

  Future<void> filter() async {
    isFiltering = true;
    notifyListeners();

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

    isFiltering = false;
    notifyListeners();
  }

  void reset() {
    value = null;
    notifyListeners();
  }
}

class XmlServiceSaveNotifier extends XmlServiceNotifier {
  XmlServiceSaveNotifier({
    required super.filePickerResultNotifier,
    required super.outputPathNotifier,
    required super.regionFirstMatchNotifier,
    required super.regionsNotifier,
  });

  bool isSaving = false;

  Future<void> save() async {
    isSaving = true;
    notifyListeners();

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

    isSaving = false;
    notifyListeners();
  }
}
