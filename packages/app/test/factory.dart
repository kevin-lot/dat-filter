import 'package:domain/domain.dart';
import 'package:xml/xml.dart';

const aFraRegion = Region(code: 'FRA', isSelected: false);

const aJpnRegion = Region(code: 'JPN', isSelected: false);

const aUsaRegion = Region(code: 'USA', isSelected: false);

final Game aFraGame1 = Game(
  originalEl: XmlElement(XmlName('game1_FRA')),
  nameOrCloneOf: 'game1_FRA',
  regions: <String>['FRA'],
);

final Game aUsaGame1 = Game(
  originalEl: XmlElement(XmlName('game1_USA')),
  nameOrCloneOf: 'game1_USA',
  regions: <String>['USA'],
);

final Game aUsaGame2 = Game(
  originalEl: XmlElement(XmlName('game2_USA')),
  nameOrCloneOf: 'game2_USA',
  regions: <String>['USA'],
);
