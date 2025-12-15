import 'package:app/data/providers/file_picker_result_notifier.dart';
import 'package:app/data/providers/output_path_notifier.dart';
import 'package:app/data/providers/preferences_notifier.dart';
import 'package:app/data/providers/regions_notifier.dart';
import 'package:app/data/providers/xml_service_notifier.dart';
import 'package:app/data/repositories/preferences_repository.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string/string.dart';

final preferencesRepositoryProvider = Provider<PreferencesRepositoryInterface>((final ref) => PreferencesRepository());
final preferencesNotifierProvider = FutureProvider<PreferencesNotifierInterface>(
  (final ref) => PreferencesNotifier(ref.watch(preferencesRepositoryProvider)),
  dependencies: [
    preferencesRepositoryProvider,
  ],
);

final filePickerResultNotifierProvider =
    Provider<FilePickerResultNotifierInterface>((final ref) => FilePickerResultNotifier());

final outputPathNotifierProvider = Provider<OutputPathNotifierInterface>((final ref) => OutputPathNotifier());

final themeColorNotifierProvider = Provider<AsyncValue<ThemeColorNotifierInterface>>(
  (final ref) {
    return ref.watch(preferencesNotifierProvider).whenData((final data) => ThemeColorNotifier(data.value));
  },
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final localeNotifierProvider = Provider<AsyncValue<LocaleNotifierInterface>>(
  (final ref) {
    return ref.watch(preferencesNotifierProvider).whenData((final data) => LocaleNotifier(data.value));
  },
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final themeModeNotifierProvider = Provider<AsyncValue<ThemeModeNotifierInterface>>(
  (final ref) {
    return ref.watch(preferencesNotifierProvider).whenData((final data) => ThemeModeNotifier(data.value));
  },
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final regionsFirstMatchNotifierProvider = Provider<AsyncValue<RegionsFirstMatchNotifierInterface>>(
  (final ref) {
    return ref.watch(preferencesNotifierProvider).whenData((final data) => RegionsFirstMatchNotifier(data.value));
  },
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final regionsNotifierProvider = Provider<AsyncValue<RegionsNotifierInterface>>(
  (final ref) {
    return ref.watch(preferencesNotifierProvider).whenData((final data) => RegionsNotifier(data.value));
  },
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final appLocalizationsNotifierProvider = Provider<AsyncValue<AppLocalizationsNotifierInterface>>(
  (final ref) {
    return ref
        .watch(localeNotifierProvider)
        .whenData((final localeNotifier) => AppLocalizationsNotifier(localeNotifier.value));
  },
  dependencies: [
    localeNotifierProvider,
  ],
);

final xmlServiceFilterNotifierProvider = Provider<AsyncValue<XmlServiceFilterNotifierInterface>>(
  (final ref) {
    final FilePickerResultNotifierInterface filePickerResultNotifier = ref.watch(filePickerResultNotifierProvider);
    final OutputPathNotifierInterface outputPathNotifier = ref.watch(outputPathNotifierProvider);
    final RegionsFirstMatchNotifierInterface? regionsFirstMatchNotifier =
        ref.watch(regionsFirstMatchNotifierProvider).value;
    final RegionsNotifierInterface? regionsNotifier = ref.watch(regionsNotifierProvider).value;

    if (regionsFirstMatchNotifier == null || regionsNotifier == null) return const AsyncLoading();

    return AsyncValue.data(
      XmlServiceFilterNotifier(
        filePickerResult: filePickerResultNotifier.value,
        outputPath: outputPathNotifier.value,
        regionFirstMatch: regionsFirstMatchNotifier.value,
        regions: regionsNotifier.value,
      ),
    );
  },
  dependencies: [
    filePickerResultNotifierProvider,
    outputPathNotifierProvider,
    regionsFirstMatchNotifierProvider,
    regionsNotifierProvider,
  ],
);

final xmlServiceSaveNotifierProvider = Provider<AsyncValue<XmlServiceSaveNotifierInterface>>(
  (final ref) {
    final FilePickerResultNotifierInterface filePickerResultNotifier = ref.watch(filePickerResultNotifierProvider);
    final OutputPathNotifierInterface outputPathNotifier = ref.watch(outputPathNotifierProvider);
    final RegionsFirstMatchNotifierInterface? regionsFirstMatchNotifier =
        ref.watch(regionsFirstMatchNotifierProvider).value;
    final RegionsNotifierInterface? regionsNotifier = ref.watch(regionsNotifierProvider).value;

    if (regionsFirstMatchNotifier == null || regionsNotifier == null) return const AsyncLoading();

    return AsyncValue.data(
      XmlServiceSaveNotifier(
        filePickerResult: filePickerResultNotifier.value,
        outputPath: outputPathNotifier.value,
        regionFirstMatch: regionsFirstMatchNotifier.value,
        regions: regionsNotifier.value,
      ),
    );
  },
  dependencies: [
    filePickerResultNotifierProvider,
    outputPathNotifierProvider,
    regionsFirstMatchNotifierProvider,
    regionsNotifierProvider,
  ],
);
