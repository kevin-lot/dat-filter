import 'dart:io';

import 'package:app/observer_provider.dart';
import 'package:app/presentation/layout.dart';
import 'package:app/service_locator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:string/string.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/theme.dart';

extension on Color {
  YaruVariant get yaruVariant =>
      YaruVariant.accents.firstWhereOrNull((final e) => e.color == this) ?? YaruVariant.accents[0];
}

void main() async {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((final LogRecord record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  FlutterError.onError = (final FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
    throw Exception('Platform not supported');
  }
  WidgetsFlutterBinding.ensureInitialized();
  // This is a workaround for a flutter bug that prevents the app from
  // becoming accessible when run from an IDE.
  //
  // The bug is that the SemanticsBinding isn't initialized until the first
  // frame is scheduled, and the first frame is scheduled by the
  // WidgetsFlutterBinding, which is initialized below.
  //
  // This means that when the app is run from an IDE, the SemanticsBinding
  // isn't initialized until the app is already running, and therefore
  // accessibility is broken.
  //
  // By calling ensureSemantics() here, we ensure that the SemanticsBinding
  // is initialized before the app is run, which fixes the bug.
  SemanticsBinding.instance.ensureSemantics();

  await WindowManager.instance.ensureInitialized();
  await windowManager.setMinimumSize(const Size(1024, 780));
  await windowManager.setMaximumSize(const Size(1024, 780));
  await windowManager.setTitle('DatFilter');
  await windowManager.waitUntilReadyToShow();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(final BuildContext context) {
    return ProviderScope(
      observers: [
        LoggerProvider(),
      ],
      child: Consumer(
        key: key,
        builder: (final context, final ref, final _) {
          /// Don't use context and prefer the appLocalizationProvider to get translations.
          /// This "watchPropertyValue" configures MaterialApp localization properties.
          final Locale? locale = ref.watch(localeNotifierProvider).value?.value;

          final ThemeMode? themeMode = ref.watch(themeModeNotifierProvider).value?.value;
          final YaruVariant yaruVariant =
              ref.watch(themeColorNotifierProvider).value?.value?.yaruVariant ?? YaruVariant.accents[0];

          if (locale == null || themeMode == null) {
            return const CircularProgressIndicator();
          }

          if (!kIsWeb && Platform.isLinux) {
            return YaruTheme(
              builder: (final BuildContext context, final YaruThemeData yaru, final Widget? child) {
                return App(
                  darkTheme: yaru.darkTheme,
                  home: child,
                  locale: locale,
                  theme: yaru.theme,
                );
              },
              data: YaruThemeData(
                themeMode: themeMode,
                variant: yaruVariant,
              ),
              child: const Layout(),
            );
          }

          return App(
            darkTheme: yaruVariant.darkTheme,
            home: const Layout(),
            locale: locale,
            theme: yaruVariant.theme,
          );
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({
    required this.home,
    required this.darkTheme,
    required this.locale,
    required this.theme,
    super.key,
  });

  // ignore: diagnostic_describe_all_properties
  final ThemeData? darkTheme;
  // ignore: unreachable_from_main
  final Widget? home;
  // ignore: diagnostic_describe_all_properties
  final Locale? locale;
  // ignore: diagnostic_describe_all_properties
  final ThemeData? theme;

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      home: home,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme,
    );
  }
}
