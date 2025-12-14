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

final themeColorNotifierProvider = Provider<ThemeColorNotifierInterface?>(
  (final ref) =>
      ref.watch(preferencesNotifierProvider).whenOrNull(data: (final data) => ThemeColorNotifier(data.value)),
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final localeNotifierProvider = Provider<LocaleNotifierInterface?>(
  (final ref) => ref.watch(preferencesNotifierProvider).whenOrNull(data: (final data) => LocaleNotifier(data.value)),
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final themeModeNotifierProvider = Provider<ThemeModeNotifierInterface>(
  (final ref) => ref.watch(preferencesNotifierProvider).when(
        data: (final data) => ThemeModeNotifier(data.value),
        error: (final Object error, final StackTrace stackTrace) => ThemeModeNotifier(const Preferences()),
        loading: () => ThemeModeNotifier(const Preferences()),
      ),
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final regionsFirstMatchNotifierProvider = Provider<RegionsFirstMatchNotifierInterface?>(
  (final ref) =>
      ref.watch(preferencesNotifierProvider).whenOrNull(data: (final data) => RegionsFirstMatchNotifier(data.value)),
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final regionsNotifierProvider = Provider<RegionsNotifierInterface?>(
  (final ref) => ref.watch(preferencesNotifierProvider).whenOrNull(data: (final data) => RegionsNotifier(data.value)),
  dependencies: [
    preferencesNotifierProvider,
  ],
);

final appLocalizationsNotifierProvider = Provider<AppLocalizationsNotifier?>(
  (final ref) {
    final LocaleNotifierInterface? localeNotifier = ref.watch(localeNotifierProvider);

    if (localeNotifier == null) return null;

    return AppLocalizationsNotifier(localeNotifier.value);
  },
  dependencies: [
    localeNotifierProvider,
  ],
);

final xmlServiceFilterNotifierProvider = Provider<XmlServiceFilterNotifierInterface?>(
  (final ref) {
    final FilePickerResultNotifierInterface filePickerResultNotifier = ref.watch(filePickerResultNotifierProvider);
    final OutputPathNotifierInterface outputPathNotifier = ref.watch(outputPathNotifierProvider);
    final RegionsFirstMatchNotifierInterface? regionsFirstMatchNotifier = ref.watch(regionsFirstMatchNotifierProvider);
    final RegionsNotifierInterface? regionsNotifier = ref.watch(regionsNotifierProvider);

    if (regionsFirstMatchNotifier == null || regionsNotifier == null) return null;

    return XmlServiceFilterNotifier(
      filePickerResult: filePickerResultNotifier.value,
      outputPath: outputPathNotifier.value,
      regionFirstMatch: regionsFirstMatchNotifier.value,
      regions: regionsNotifier.value,
    );
  },
  dependencies: [
    filePickerResultNotifierProvider,
    outputPathNotifierProvider,
    regionsFirstMatchNotifierProvider,
    regionsNotifierProvider,
  ],
);

final xmlServiceSaveNotifierProvider = Provider<XmlServiceSaveNotifierInterface?>(
  (final ref) {
    final FilePickerResultNotifierInterface filePickerResultNotifier = ref.watch(filePickerResultNotifierProvider);
    final OutputPathNotifierInterface outputPathNotifier = ref.watch(outputPathNotifierProvider);
    final RegionsFirstMatchNotifierInterface? regionsFirstMatchNotifier = ref.watch(regionsFirstMatchNotifierProvider);
    final RegionsNotifierInterface? regionsNotifier = ref.watch(regionsNotifierProvider);

    if (regionsFirstMatchNotifier == null || regionsNotifier == null) return null;

    return XmlServiceSaveNotifier(
      filePickerResult: filePickerResultNotifier.value,
      outputPath: outputPathNotifier.value,
      regionFirstMatch: regionsFirstMatchNotifier.value,
      regions: regionsNotifier.value,
    );
  },
  dependencies: [
    filePickerResultNotifierProvider,
    outputPathNotifierProvider,
    regionsFirstMatchNotifierProvider,
    regionsNotifierProvider,
  ],
);
