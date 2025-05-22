import 'package:app/module/language/widget/language_selector.dart';
import 'package:app/module/theme_brightness/widget/brightness_selector.dart';
import 'package:app/module/theme_color/widget/color_selector.dart';
import 'package:artistic/artistic.dart';
import 'package:domain/domain.dart'
    show
        AppLocalizationsInterface,
        AppLocalizationsNotifierInterface,
        ListRegionExtension,
        LocaleNotifierInterface,
        Preferences,
        PreferencesNotifierInterface,
        Region,
        RegionsFirstMatchNotifierInterface,
        RegionsNotifierInterface,
        ThemeColorNotifierInterface,
        ThemeModeNotifierInterface;
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:yaru/theme.dart';
import 'package:yaru/widgets.dart';

class Settings extends WatchingWidget {
  const Settings({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppLocalizationsInterface appLocalizations =
        watchPropertyValue((final AppLocalizationsNotifierInterface n) => n.value);
    final List<Region> configRegions = watchPropertyValue((final RegionsNotifierInterface n) => n.value).selected;
    final bool configRegionsFirstMatch = watchPropertyValue((final RegionsFirstMatchNotifierInterface n) => n.value);
    final Locale locale = watchPropertyValue((final LocaleNotifierInterface n) => n.value);
    final ThemeMode themeBrightness = watchPropertyValue((final ThemeModeNotifierInterface n) => n.value);
    final Color themeColor =
        watchPropertyValue((final ThemeColorNotifierInterface n) => n.value) ?? YaruVariant.accents[0].color;

    return SimpleDialog(
      contentPadding: const EdgeInsets.all(MagicSpaces.primary),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: MagicSpaces.dialogMarginLarge,
        vertical: MagicSpaces.dialogMarginPrimary,
      ),
      title: YaruDialogTitleBar(centerTitle: false, title: Text(appLocalizations.settings)),
      titlePadding: EdgeInsets.zero,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(flex: 2, child: Text(appLocalizations.language)),
            const Flexible(fit: FlexFit.tight, flex: 3, child: LanguageSelector()),
          ],
        ),
        const SizedBox(height: MagicSpaces.primary),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(flex: 2, child: Text(appLocalizations.mode)),
            const Flexible(fit: FlexFit.tight, flex: 3, child: BrightnessSelector()),
          ],
        ),
        const SizedBox(height: MagicSpaces.primary),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(flex: 2, child: Text(appLocalizations.theme)),
            const Flexible(flex: 3, child: ColorSelector()),
          ],
        ),
        const SizedBox(height: MagicSpaces.primary),
        ElevatedButton(
          onPressed: () async {
            await _saveAll(
              configRegions,
              configRegionsFirstMatch,
              locale,
              themeBrightness,
              themeColor,
            );

            if (context.mounted) await Navigator.maybePop(context);
          },
          child: Text(appLocalizations.saveSettings),
        ),
      ],
    );
  }

  Future<void> _saveAll(
    final List<Region> configRegions,
    final bool configRegionsFirstMatch,
    final Locale locale,
    final ThemeMode themeBrightness,
    final Color themeColor,
  ) async {
    final Preferences preferences = Preferences(
      locale: locale,
      configRegions: configRegions,
      configRegionsFirstMatch: configRegionsFirstMatch,
      themeMode: themeBrightness,
      themeColor: themeColor,
    );
    await di<PreferencesNotifierInterface>().save(preferences);
  }
}
