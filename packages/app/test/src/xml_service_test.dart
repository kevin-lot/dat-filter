import 'package:app/feature/usecase/xml_service.dart';
import 'package:domain/domain.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

import '../factory.dart';

void main() {
  group('XmlServices', () {
    final datafile = Datafile(
      gamesByName: <String, List<Game>>{
        'game1': <Game>[
          aUsaGame1,
          aFraGame1,
          Game(originalEl: XmlElement(XmlName('game1_JPN')), nameOrCloneOf: 'game1_JPN', regions: <String>['JPN']),
        ],
        'game2': <Game>[
          Game(originalEl: XmlElement(XmlName('game2_CAN')), nameOrCloneOf: 'game2_CAN', regions: <String>['CAN']),
          aUsaGame2,
        ],
        'game3': <Game>[
          Game(originalEl: XmlElement(XmlName('game3_CAN')), nameOrCloneOf: 'game3_CAN', regions: <String>['CAN']),
          Game(originalEl: XmlElement(XmlName('game3_JPN')), nameOrCloneOf: 'game3_JPN', regions: <String>['JPN']),
        ],
      },
      header: XmlElement(XmlName('header')),
      originalGamesCount: 3,
    );

    final List<Region> regionsToFilter = <Region>[
      aFraRegion.copyWith(isSelected: true),
      aUsaRegion.copyWith(isSelected: true),
      aJpnRegion.copyWith(isSelected: false),
    ];

    test('allMatchListOfGames(final Datafile datafile)', () {
      final Datafile result = XmlService(
        filePickerResult: const FilePickerResult(<PlatformFile>[]),
        outputPath: '',
        regionsToFilter: regionsToFilter,
        typeOfMatch: TypeOfMatchRegionEnum.allMatch,
      ).allMatchListOfGames(datafile);

      final Datafile expected = datafile.copyWith(
        gamesByName: <String, List<Game>>{
          'game1': <Game>[aUsaGame1, aFraGame1],
          'game2': <Game>[aUsaGame2],
        },
      );
      expect(
        result,
        equals(expected),
      );
    });

    test('firstMatchListOfGames(final Map<String, List<Game>> listOfListGames)', () {
      final Datafile result = XmlService(
        filePickerResult: const FilePickerResult(<PlatformFile>[]),
        outputPath: '',
        regionsToFilter: regionsToFilter,
        typeOfMatch: TypeOfMatchRegionEnum.allMatch,
      ).firstMatchListOfGames(datafile);

      final Datafile expected = datafile.copyWith(
        gamesByName: <String, List<Game>>{
          'game1': <Game>[aFraGame1],
          'game2': <Game>[aUsaGame2],
        },
      );
      expect(
        result,
        equals(expected),
      );
    });
  });
}
