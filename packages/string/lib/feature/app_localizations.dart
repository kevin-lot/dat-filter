import 'dart:async';

import 'package:domain/domain.dart' show AppLocalizationsInterface;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'feature/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations implements AppLocalizationsInterface {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('fr')];

  /// Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Close
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Keep all the releases that match the selection
  ///
  /// In en, this message translates to:
  /// **'Keep all the releases that match the selection.'**
  String get configNoStopOnFirstMatchDescription;

  /// Regions
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get configRegions;

  /// Stop on the first match
  ///
  /// In en, this message translates to:
  /// **'Stop on the first match'**
  String get configStopOnFirstMatch;

  /// Keep the first release that matches the selection keeping the order
  ///
  /// In en, this message translates to:
  /// **'Keep the first release that matches the ordered selection.'**
  String get configStopOnFirstMatchDescription;

  /// Go
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// Language:
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get language;

  /// Mode:
  ///
  /// In en, this message translates to:
  /// **'Mode :'**
  String get mode;

  /// Output directory
  ///
  /// In en, this message translates to:
  /// **'Output directory'**
  String get outputDir;

  /// Process
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// Pick files
  ///
  /// In en, this message translates to:
  /// **'Pick files'**
  String get pickInputFiles;

  /// Pick a directory
  ///
  /// In en, this message translates to:
  /// **'Pick a directory'**
  String get pickOutputDir;

  /// Australia
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get region_AUS;

  /// Brazil
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get region_bz;

  /// Canada
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get region_CAN;

  /// China
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get region_ch;

  /// England
  ///
  /// In en, this message translates to:
  /// **'England'**
  String get region_en;

  /// France
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get region_FRA;

  /// Germany
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get region_GER;

  /// Hong Kong
  ///
  /// In en, this message translates to:
  /// **'Hong Kong'**
  String get region_hk;

  /// Italy
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get region_ITA;

  /// Japan
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get region_JPN;

  /// Korea
  ///
  /// In en, this message translates to:
  /// **'Korea'**
  String get region_KOR;

  /// Netherlands
  ///
  /// In en, this message translates to:
  /// **'Netherlands'**
  String get region_nh;

  /// Spain
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get region_SPA;

  /// Sweden
  ///
  /// In en, this message translates to:
  /// **'Sweden'**
  String get region_sw;

  /// Taiwan
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get region_TAI;

  /// USA
  ///
  /// In en, this message translates to:
  /// **'USA'**
  String get region_USA;

  /// Asia
  ///
  /// In en, this message translates to:
  /// **'Asia'**
  String get region_as;

  /// Europe
  ///
  /// In en, this message translates to:
  /// **'Europe'**
  String get region_EUR;

  /// Japan - Europe
  ///
  /// In en, this message translates to:
  /// **'Japan - Europe'**
  String get region_jp_eu;

  /// Japan - USA
  ///
  /// In en, this message translates to:
  /// **'Japan - USA'**
  String get region_jp_us;

  /// USA - Europe
  ///
  /// In en, this message translates to:
  /// **'USA - Europe'**
  String get region_us_eu;

  /// World
  ///
  /// In en, this message translates to:
  /// **'World'**
  String get region_w;

  /// Save settings
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get saveSettings;

  /// Select all
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// Selected
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Sort selection
  ///
  /// In en, this message translates to:
  /// **'Sort selection'**
  String get sortSelection;

  /// Summary
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// Theme:
  ///
  /// In en, this message translates to:
  /// **'Theme :'**
  String get theme;

  /// Total
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Unselect all
  ///
  /// In en, this message translates to:
  /// **'Unselect all'**
  String get unselectAll;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError('AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
