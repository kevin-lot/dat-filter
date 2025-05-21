import 'package:app/src/domain/model/game.dart';
import 'package:app/src/domain/model/region.dart';
import 'package:xml/xml.dart';

const aFraRegion = Region(code: 'FRA', isSelected: false);

const aJpnRegion = Region(code: 'JPN', isSelected: false);

const aUsaRegion = Region(code: 'USA', isSelected: false);

Game aFraGame1 = Game(
  originalEl: XmlElement(XmlName('game1_FRA')),
  cloneOrName: 'game1_FRA',
  regions: <String>['FRA'],
);

Game aUsaGame1 = Game(
  originalEl: XmlElement(XmlName('game1_USA')),
  cloneOrName: 'game1_USA',
  regions: <String>['USA'],
);

Game aUsaGame2 = Game(
  originalEl: XmlElement(XmlName('game2_USA')),
  cloneOrName: 'game2_USA',
  regions: <String>['USA'],
);
