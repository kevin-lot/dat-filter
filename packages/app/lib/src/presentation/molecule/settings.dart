import 'package:app/src/domain/model/region.dart';
import 'package:app/src/infra/provider/regions_state.dart';
import 'package:app/src/presentation/molecule/brightness_picker.dart';
import 'package:app/src/presentation/molecule/language_picker.dart';
import 'package:app/src/presentation/molecule/theme_picker.dart';
import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:infra/infra_repositories.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';

class Settings extends WatchingWidget {
  const Settings({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier s) => s.value);
    final List<String> configRegions = watchPropertyValue((final RegionsNotifier s) => s.value).selected.codes;
    final bool configRegionsFirstMatch = watchPropertyValue((final RegionsFirstMatchNotifier s) => s.value);
    final Locale locale = watchPropertyValue((final LocaleNotifier s) => s.value);
    final ThemeMode themeBrightness = watchPropertyValue((final ThemeModeNotifier s) => s.value);
    final Color themeColor = watchPropertyValue((final ColorNotifier s) => s.value) ?? YaruVariant.accents[0].color;

    return Column(
      spacing: Spaces.primary,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(appLocalizations.language),
            const LanguagePicker(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(appLocalizations.mode),
            const BrightnessPicker(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(appLocalizations.theme),
            const ThemePicker(),
          ],
        ),
        ElevatedButton(
          onPressed: () async =>
              await _saveAll(configRegions, configRegionsFirstMatch, locale, themeBrightness, themeColor),
          child: Text(appLocalizations.saveSettings),
        ),
      ],
    );
  }

  Future<void> _saveAll(
    final List<String> configRegions,
    final bool configRegionsFirstMatch,
    final Locale locale,
    final ThemeMode themeBrightness,
    final Color themeColor,
  ) async {
    final Preferences preferences = Preferences(
      language: locale.languageCode,
      configRegions: configRegions,
      configRegionsFirstMatch: configRegionsFirstMatch,
      themeMode: themeBrightness,
      themeColor: themeColor,
    );
    await di<PreferencesNotifier>().save(preferences);
  }
}
