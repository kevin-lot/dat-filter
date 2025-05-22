import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'datafile.freezed.dart';

typedef GamesByName = Map<String, List<Game>>;

extension GamesByNameExtension on GamesByName {
  int get totalLength => values.fold(0, (final int previous, final List<Game> games) => previous + games.length);
}

@freezed
abstract class Datafile with _$Datafile {
  const factory Datafile({
    required final GamesByName gamesByName,
    required final XmlElement header,
    required final int originalGamesCount,
  }) = _Datafile;
}
