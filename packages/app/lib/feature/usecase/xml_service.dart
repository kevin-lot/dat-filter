import 'dart:io';
import 'dart:isolate';

import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';

extension on PlatformFile {
  File toFile() {
    if (path == null) {
      throw Exception('path cannot be null');
    }

    return File(path!);
  }
}

class XmlService {
  const XmlService({
    required this.filePickerResult,
    required this.outputPath,
    required this.regionsToFilter,
    required this.typeOfMatch,
  });

  final FilePickerResult filePickerResult;
  final String outputPath;
  final List<Region> regionsToFilter;
  final TypeOfMatchRegionEnum typeOfMatch;

  Future<Map<PlatformFile, Datafile>> filter() async {
    final List<Future<MapEntry<PlatformFile, Datafile>>> isolates = [
      for (final PlatformFile platformFile in filePickerResult.files)
        Isolate.run(() async {
          final Datafile allGames = await _build(platformFile.toFile());
          final Datafile filteredGames = _getFilteredGames(allGames, typeOfMatch);
          return MapEntry<PlatformFile, Datafile>(platformFile, filteredGames);
        }),
    ];
    final List<MapEntry<PlatformFile, Datafile>> entries = await Future.wait(isolates);

    return Map.fromEntries(entries);
  }

  Future<void> save() async {
    final Map<PlatformFile, Datafile> results = await filter();

    for (final MapEntry<PlatformFile, Datafile> result in results.entries) {
      final PlatformFile platformFile = result.key;
      final file = File('$outputPath/${platformFile.name}');
      final Datafile datafile = result.value;

      final List<Game> games = datafile.gamesByName.values.expand((final i) => i).toList();

      final document = XmlDocument([
        XmlProcessing('xml', 'version="1.0"'),
        XmlElement(
          XmlName('datafile'),
          [],
          [
            datafile.header.copy(),
            for (final Game game in games) game.originalEl.copy(),
          ],
        ),
      ]);

      await file.writeAsString(document.toXmlString(pretty: true));
    }
  }

  /// Filter games that don't have a wanted region.
  @visibleForTesting
  Datafile allMatchListOfGames(final Datafile datafile) {
    final Iterable<MapEntry<String, List<Game>>> entries = datafile.gamesByName.entries.map(
      (final MapEntry<String, List<Game>> entry) {
        // Filter games that match the selected regions
        final List<Game> filteredGames =
            entry.value.where((final Game game) => game.regions.hasRegions(regionsToFilter)).toList();

        return MapEntry<String, List<Game>>(entry.key, filteredGames);
      },
    ).where((final MapEntry<String, List<Game>> entry) => entry.value.isNotEmpty);

    return datafile.copyWith(gamesByName: GamesByName.fromEntries(entries));
  }

  /// Filter games that don't have a wanted region.
  /// And keep only the prefer game from the ordered list of region.
  @visibleForTesting
  Datafile firstMatchListOfGames(final Datafile datafile) {
    final Iterable<MapEntry<String, List<Game>>> entries = datafile.gamesByName.entries.map(
      (final MapEntry<String, List<Game>> entry) {
        final String name = entry.key;
        final List<Game> games = entry.value;

        bool alreadyMatched = false;

        // Filter games that match the first region that it can
        final List<Game> filteredGames = regionsToFilter.fold(
          <Game>[],
          (final List<Game> previous, final Region regionToFilter) {
            if (alreadyMatched) return previous;

            for (final Game game in games) {
              if (!game.regions.hasRegions(<Region>[regionToFilter])) continue;

              alreadyMatched = true;
              return <Game>[...previous, game];
            }

            return previous;
          },
        );

        return MapEntry<String, List<Game>>(name, filteredGames);
      },
    ).where((final MapEntry<String, List<Game>> entry) => entry.value.isNotEmpty);

    return datafile.copyWith(gamesByName: GamesByName.fromEntries(entries));
  }

  /// Index all games with the same name or the same cloneOf.
  /// The game is a [Game] instance.
  ///
  /// Exemple of xml:
  ///
  /// `<?xml version="1.0"?>`
  /// `<datafile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://datomatic.no-intro.org/stuff https://datomatic.no-intro.org/stuff/schema_nointro_datfile_v3.xsd">`
  ///   `<header>`
  ///     `<id>64</id>`
  ///     `<name>Nintendo - Nintendo 3DS (Encrypted) (Parent-Clone)</name>`
  ///     `<description>Nintendo - Nintendo 3DS (Encrypted) (Parent-Clone)</description>`
  ///     `<version>20250513-130557</version>`
  ///     `<date>20250513-130557</date>`
  ///     `<author>aci68, ajax16384, ajshell1, Arctic Circle System, Aringon, b2071988, Bent, buckwheat, C. V. Reynolds, Connie, coraz, Datman, DeadSkullzJr, Densetsu, EggmanPEI, einstein95, Fonix, Gefflon, Hiccup, InternalLoss, Jack, jimmsu, Just001Kim, Larsenv, MeguCocoa, MisterSheeple, Money_114, NESBrew12, nnssxx, NovaAurora, number, PPLToast, psykopat, rarenight, relax, Rifu, scorp256, SonGoku, Tauwasser, TBemme, togemet2, u53r123, Xenirina, xprism, xuom2, ZeroSkill, zg, Zora</author>`
  ///     `<url>https://www.no-intro.org</url>`
  ///   `</header>`
  ///   `<game name="[BIOS] Nintendo 3DS ARM11 Boot ROM (World)">`
  ///     `<description>[BIOS] Nintendo 3DS ARM11 Boot ROM (World)</description>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM11 Boot ROM (World)" region="EUR"/>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM11 Boot ROM (World)" region="JPN"/>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM11 Boot ROM (World)" region="USA"/>`
  ///     `<rom name="[BIOS] Nintendo 3DS ARM11 Boot ROM (World).bin" size="65536" crc="39ed2007" md5="43454041b0cddf1a34c130593afa8b9b" sha1="f81039bbc208a54d9c6dec31bd5d30f6ec09d2bd"/>`
  ///   `</game>`
  ///   `<game name="[BIOS] Nintendo 3DS ARM9 Boot ROM (World)">`
  ///     `<description>[BIOS] Nintendo 3DS ARM9 Boot ROM (World)</description>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM9 Boot ROM (World)" region="EUR"/>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM9 Boot ROM (World)" region="JPN"/>`
  ///     `<release name="[BIOS] Nintendo 3DS ARM9 Boot ROM (World)" region="USA"/>`
  ///     `<rom name="[BIOS] Nintendo 3DS ARM9 Boot ROM (World).bin" size="65536" crc="e0989f6d" md5="d8675e80e5dd3a9afaaf885d79b14e9c" sha1="5a3d3d6df4743e6b50afe0fc717fa8a12bc888e6"/>`
  ///   `</game>`
  /// `</datafile>`
  Future<Datafile> _build(final File file) async {
    final String fileString = await file.readAsString();
    final XmlDocument document = XmlDocument.parse(fileString);

    final XmlElement header = document.findAllElements('header').single;
    final Iterable<XmlElement> originalGames = document.findAllElements('game');

    final int originalGamesCount = originalGames.length;
    final GamesByName games = originalGames.fold(
      <String, List<Game>>{},
      (final GamesByName previous, final XmlElement el) {
        final String? cloneOrName = el.getAttribute('cloneof') ?? el.getAttribute('name');
        if (cloneOrName == null) {
          return previous;
        }

        final Game game = _buildGame(cloneOrName, el);

        final List<Game> previousOrInit = previous[cloneOrName] ?? <Game>[];
        previous[cloneOrName] = <Game>[...previousOrInit, game];

        return previous;
      },
    );

    return Datafile(gamesByName: games, header: header, originalGamesCount: originalGamesCount);
  }

  Game _buildGame(final String key, final XmlElement el) {
    return Game(
      nameOrCloneOf: key,
      originalEl: el,
      regions: _buildRegions(el),
    );
  }

  /// Returns a list of string with region name.
  List<String> _buildRegions(final XmlElement xmlElement) {
    return xmlElement
        .findElements('release')
        .map((final XmlElement el) => el.getAttribute('region'))
        .whereType<String>()
        .toList();
  }

  Datafile _getFilteredGames(final Datafile games, final TypeOfMatchRegionEnum typeOfMatch) {
    switch (typeOfMatch) {
      case TypeOfMatchRegionEnum.allMatch:
        return allMatchListOfGames(games);
      case TypeOfMatchRegionEnum.firstMatch:
        return firstMatchListOfGames(games);
    }
  }
}
