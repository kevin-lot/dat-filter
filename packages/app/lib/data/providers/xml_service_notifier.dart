import 'dart:async';
import 'dart:io';

import 'package:app/data/providers/regions_notifier.dart';
import 'package:app/feature/usecase/xml_service.dart';
import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class XmlServiceNotifier<T> extends AsyncNotifier<T> {
  XmlServiceNotifier({
    required this.filePickerResult,
    required this.outputPath,
    required this.regionFirstMatch,
    required this.regions,
  });

  final FilePickerResult? filePickerResult;
  final List<Region>? regions;
  final String? outputPath;
  final bool? regionFirstMatch;
}

class XmlServiceFilterNotifier extends XmlServiceNotifier<Map<PlatformFile, Datafile>?>
    implements XmlServiceFilterNotifierInterface {
  XmlServiceFilterNotifier({
    required super.filePickerResult,
    required super.outputPath,
    required super.regionFirstMatch,
    required super.regions,
  });

  @override
  Map<PlatformFile, Datafile>? get value => state.value;

  @override
  Future<Map<PlatformFile, Datafile>?> build() {
    state = const AsyncValue.data(null);
    return Future.value(null);
  }

  @override
  Future<void> filter() async {
    assert(
      !(filePickerResult == null || regions == null || outputPath == null || regionFirstMatch == null),
      'XmlService: missing requirements to filter (filePickerResult: $filePickerResult, regions: $regions, outputPath: $outputPath, regionFirstMatch: $regionFirstMatch)',
    );

    state = const AsyncValue.loading();
    final Map<PlatformFile, Datafile> result = await XmlService(
      filePickerResult: filePickerResult!,
      outputPath: outputPath!,
      regionsToFilter: regions!,
      typeOfMatch: regionFirstMatch!.toEnum(),
    ).filter();
    state = AsyncValue.data(result);
  }

  @override
  void reset() {
    state = const AsyncValue.data(null);
  }
}

class XmlServiceSaveNotifier extends XmlServiceNotifier<File?> implements XmlServiceSaveNotifierInterface {
  XmlServiceSaveNotifier({
    required super.filePickerResult,
    required super.outputPath,
    required super.regionFirstMatch,
    required super.regions,
  });

  @override
  Future<File?> build() {
    state = const AsyncValue.data(null);
    return Future.value(null);
  }

  @override
  Future<void> save() async {
    assert(
      !(filePickerResult == null || regions == null || outputPath == null || regionFirstMatch == null),
      'XmlService: missing requirements to save (filePickerResult: $filePickerResult, regions: $regions, outputPath: $outputPath, regionFirstMatch: $regionFirstMatch)',
    );

    state = const AsyncValue.loading();
    final File file = await XmlService(
      filePickerResult: filePickerResult!,
      outputPath: outputPath!,
      regionsToFilter: regions!,
      typeOfMatch: regionFirstMatch!.toEnum(),
    ).save();
    state = AsyncValue.data(file);
  }
}
