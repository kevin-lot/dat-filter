import 'package:app/data/providers/file_picker_result_notifier.dart';
import 'package:app/data/providers/output_path_notifier.dart';
import 'package:app/data/providers/preferences_notifier.dart';
import 'package:app/data/providers/regions_notifier.dart';
import 'package:app/data/providers/xml_service_notifier.dart';
import 'package:app/data/repositories/preferences_repository.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

Future<void> serviceLocator() async {
  di
    ..registerSingleton<FilePickerResultNotifierInterface>(FilePickerResultNotifier())
    ..registerSingleton<OutputPathNotifierInterface>(OutputPathNotifier())
    ..registerSingleton<PreferencesRepositoryInterface>(PreferencesRepository());

  final Iterable<Type> dependsOn1 = [PreferencesNotifierInterface];
  final Iterable<Type> dependsOn2 = [...dependsOn1, LocaleNotifierInterface];
  final Iterable<Type> dependsOn3 = [...dependsOn2, RegionsFirstMatchNotifierInterface, RegionsNotifierInterface];

  di
    ..registerSingletonAsync<PreferencesNotifierInterface>(
      () async {
        final preferencesNotifier = PreferencesNotifier(di<PreferencesRepositoryInterface>());
        await preferencesNotifier.init();
        return preferencesNotifier;
      },
    )
    ..registerSingletonWithDependencies<ThemeColorNotifierInterface>(
      () => ThemeColorNotifier(di<PreferencesNotifierInterface>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<LocaleNotifierInterface>(
      () => LocaleNotifier(di<PreferencesNotifierInterface>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<ThemeModeNotifierInterface>(
      () => ThemeModeNotifier(di<PreferencesNotifierInterface>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<RegionsFirstMatchNotifierInterface>(
      () => RegionsFirstMatchNotifier(di<PreferencesNotifierInterface>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<RegionsNotifierInterface>(
      () => RegionsNotifier(di<PreferencesNotifierInterface>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<AppLocalizationsNotifierInterface>(
      () => AppLocalizationsNotifier(di<LocaleNotifierInterface>()),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<XmlServiceFilterNotifierInterface>(
      () => XmlServiceFilterNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifierInterface>(),
        outputPathNotifier: di<OutputPathNotifierInterface>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifierInterface>(),
        regionsNotifier: di<RegionsNotifierInterface>(),
      ),
      dependsOn: dependsOn3,
    )
    ..registerSingletonWithDependencies<XmlServiceSaveNotifierInterface>(
      () => XmlServiceSaveNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifierInterface>(),
        outputPathNotifier: di<OutputPathNotifierInterface>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifierInterface>(),
        regionsNotifier: di<RegionsNotifierInterface>(),
      ),
      dependsOn: dependsOn3,
    );

  await di.allReady();
}
