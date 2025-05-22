import 'package:app/src/infra/provider/file_picker_result_notifier.dart';
import 'package:app/src/infra/provider/output_path_notifier.dart';
import 'package:app/src/infra/provider/regions_notifier.dart';
import 'package:app/src/infra/provider/xml_service_notifier.dart';
import 'package:dimension/dimension.dart';
import 'package:domain/domain.dart';
import 'package:preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';

Future<void> serviceLocator() async {
  di
    ..registerSingleton<FilePickerResultNotifier>(FilePickerResultNotifier())
    ..registerSingleton<OutputPathNotifier>(OutputPathNotifier());

  final Iterable<Type> dependsOn1 = [SharedPreferencesAsync];
  final Iterable<Type> dependsOn2 = [...dependsOn1, PreferencesPort];
  final Iterable<Type> dependsOn3 = [...dependsOn2, LocaleNotifier];
  final Iterable<Type> dependsOn4 = [...dependsOn3, RegionsFirstMatchNotifier, RegionsNotifier];
  di
    ..registerSingletonAsync<SharedPreferencesAsync>(
      () async => SharedPreferencesAsync(),
    )
    ..registerSingletonAsync<PreferencesPort>(
      () async {
        final preferencesNotifier = PreferencesNotifier(di<SharedPreferencesAsync>());
        await preferencesNotifier.init();
        return preferencesNotifier;
      },
      dependsOn: dependsOn1,
    )
    ..registerSingletonWithDependencies<ColorPort>(
      () => ColorNotifier(di<PreferencesPort>().value),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<LocaleNotifier>(
      () => LocaleNotifier(di<PreferencesPort>().value),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<ThemeModePort>(
      () => ThemeModeNotifier(di<PreferencesPort>().value),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<RegionsFirstMatchNotifier>(
      () => RegionsFirstMatchNotifier(di<PreferencesPort>().value),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<RegionsNotifier>(
      () => RegionsNotifier(di<PreferencesPort>().value),
      dependsOn: dependsOn2,
    )
    ..registerSingletonWithDependencies<AppLocalizationsNotifier>(
      () => AppLocalizationsNotifier(di<LocaleNotifier>()),
      dependsOn: dependsOn3,
    )
    ..registerSingletonWithDependencies<XmlServiceFilterNotifier>(
      () => XmlServiceFilterNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifier>(),
        outputPathNotifier: di<OutputPathNotifier>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifier>(),
        regionsNotifier: di<RegionsNotifier>(),
      ),
      dependsOn: dependsOn4,
    )
    ..registerSingletonWithDependencies<XmlServiceSaveNotifier>(
      () => XmlServiceSaveNotifier(
        filePickerResultNotifier: di<FilePickerResultNotifier>(),
        outputPathNotifier: di<OutputPathNotifier>(),
        regionFirstMatchNotifier: di<RegionsFirstMatchNotifier>(),
        regionsNotifier: di<RegionsNotifier>(),
      ),
      dependsOn: dependsOn4,
    );

  await di.allReady();
}
