import 'package:app/src/infra/provider/regions_notifier.dart';
import 'package:app/src/presentation/atom/select_color_picker.dart';
import 'package:app/src/presentation/molecule/brightness_picker.dart';
import 'package:app/src/presentation/molecule/language_picker.dart';
import 'package:dimension/dimension.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:string/string.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';

class Settings extends WatchingWidget {
  const Settings({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizations appLocalizations = watchPropertyValue((final AppLocalizationsNotifier n) => n.value);
    final List<String> configRegions = watchPropertyValue((final RegionsNotifier n) => n.value).selected.codes;
    final bool configRegionsFirstMatch = watchPropertyValue((final RegionsFirstMatchNotifier n) => n.value);
    final Locale locale = watchPropertyValue((final LocaleNotifier n) => n.value);
    final ThemeMode themeBrightness = watchPropertyValue((final ThemeModePort n) => n.value);
    final Color themeColor = watchPropertyValue((final ColorPort n) => n.value) ?? YaruVariant.accents[0].color;

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
            const _ThemePicker(),
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
    await di<PreferencesPort>().save(preferences);
  }
}

class _ThemePicker extends WatchingWidget {
  const _ThemePicker();

  @override
  Widget build(final BuildContext context) {
    final Color color = watchPropertyValue((final ColorPort n) => n.value) ?? YaruVariant.accents[0].color;

    return SelectColorPicker(
      onChanged: (final Color newValue) => di<ColorPort>().setColor(newValue),
      firstValue: color,
    );
  }
}
