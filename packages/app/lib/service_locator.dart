import 'package:app/feature/provider/file_picker_result_notifier.dart';
import 'package:app/feature/provider/output_path_notifier.dart';
import 'package:app/feature/provider/preferences_notifier.dart';
import 'package:app/feature/provider/regions_notifier.dart';
import 'package:app/feature/provider/xml_service_notifier.dart';
import 'package:artistic/artistic.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

Future<void> serviceLocator() async {
  di
    ..registerSingleton<FilePickerResultNotifier>(FilePickerResultNotifier())
    ..registerSingleton<OutputPathNotifier>(OutputPathNotifier());

  final Iterable<Type> dependsOn1 = [PreferencesNotifier];
  final Iterable<Type> dependsOn2 = [...dependsOn1, LocaleNotifier];
  final Iterable<Type> dependsOn3 = [...dependsOn2, RegionsFirstMatchNotifier, RegionsNotifier];
  di
    ..registerSingletonAsync<PreferencesNotifier>(
      () async {
        final preferencesNotifier = PreferencesNotifier();
        await preferencesNotifier.init();
        return preferencesNotifier;
      },
    )
    ..registerSingletonWithDependencies<ColorNotifier>(
      () => ColorNotifier(di<PreferencesNotifier>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<LocaleNotifier>(
      () => LocaleNotifier(di<PreferencesNotifier>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<ThemeModeNotifier>(
      () => ThemeModeNotifier(di<PreferencesNotifier>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<RegionsFirstMatchNotifier>(
      () => RegionsFirstMatchNotifier(di<PreferencesNotifier>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<RegionsNotifier>(
      () => RegionsNotifier(di<PreferencesNotifier>().value),
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<AppLocalizationsNotifier>(
      () => AppLocalizationsNotifier(di<LocaleNotifier>()),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<XmlServiceFilterNotifier>(
      () => XmlServiceFilterNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifier>(),
        outputPathNotifier: di<OutputPathNotifier>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifier>(),
        regionsNotifier: di<RegionsNotifier>(),
      ),
      dependsOn: dependsOn3,
    )
    ..registerSingletonWithDependencies<XmlServiceSaveNotifier>(
      () => XmlServiceSaveNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifier>(),
        outputPathNotifier: di<OutputPathNotifier>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifier>(),
        regionsNotifier: di<RegionsNotifier>(),
      ),
      dependsOn: dependsOn3,
    );

  await di.allReady();
}
