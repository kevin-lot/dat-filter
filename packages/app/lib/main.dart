import 'dart:io';

import 'package:app/service_locator.dart';
import 'package:app/src/presentation/organism/layout.dart';
import 'package:collection/collection.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:logging/logging.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaru/settings.dart';
import 'package:yaru/theme.dart';

extension on Color? {
  YaruVariant get yaruVariant => this == null
      ? YaruVariant.accents[0]
      : YaruVariant.accents.firstWhereOrNull((final e) => e.color == this) ?? YaruVariant.accents[0];
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
  await windowManager.waitUntilReadyToShow();
  await windowManager.setMinimumSize(const Size(1024, 780));
  await windowManager.setMaximumSize(const Size(1024, 780));
  await windowManager.setTitle('DatFilter');

  await serviceLocator();

  runApp(const Main());
}

class Main extends WatchingWidget {
  const Main({super.key});

  @override
  Widget build(final BuildContext context) {
    /// Don't use context and prefer the appLocalizationProvider to get translations.
    /// This "watchPropertyValue" configures MaterialApp localization properties.
    final Locale locale = watchPropertyValue((final LocaleNotifier s) => s.value);
    final ThemeMode themeMode = watchPropertyValue((final ThemeModeNotifier s) => s.value);
    final YaruVariant yaruVariant = watchPropertyValue((final ColorNotifier s) => s.value).yaruVariant;

    if (!kIsWeb && Platform.isLinux) {
      return YaruTheme(
        builder: (final BuildContext context, final YaruThemeData yaru, final Widget? child) {
          return MaterialApp(
            themeMode: themeMode,
            home: const Layout(),
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: yaruVariant.theme,
            darkTheme: yaruVariant.darkTheme,
          );
        },
      );
    }

    return MaterialApp(
      home: const Layout(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: yaruVariant.theme,
      darkTheme: yaruVariant.darkTheme,
    );
  }
}
