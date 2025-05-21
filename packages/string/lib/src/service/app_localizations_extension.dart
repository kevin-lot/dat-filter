import 'package:string/string.dart' show AppLocalizations;

extension AppLocalizationsExtension on AppLocalizations {
  String getTranslatedRegion(final String name) {
    switch (name) {
      case 'region_AUS':
        return region_AUS;
      case 'region_bz':
        return region_bz;
      case 'region_CAN':
        return region_CAN;
      case 'region_ch':
        return region_ch;
      case 'region_en':
        return region_en;
      case 'region_FRA':
        return region_FRA;
      case 'region_GER':
        return region_GER;
      case 'region_hk':
        return region_hk;
      case 'region_ITA':
        return region_ITA;
      case 'region_JPN':
        return region_JPN;
      case 'region_KOR':
        return region_KOR;
      case 'region_nh':
        return region_nh;
      case 'region_SPA':
        return region_SPA;
      case 'region_sw':
        return region_sw;
      case 'region_TAI':
        return region_TAI;
      case 'region_USA':
        return region_USA;
      case 'region_as':
        return region_as;
      case 'region_EUR':
        return region_EUR;
      case 'region_jp_eu':
        return region_jp_eu;
      case 'region_jp_us':
        return region_jp_us;
      case 'region_us_eu':
        return region_us_eu;
      case 'region_w':
        return region_w;
    }

    return 'Not translated: $name';
  }
}
