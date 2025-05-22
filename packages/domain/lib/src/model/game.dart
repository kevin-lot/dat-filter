import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xml/xml.dart';

part 'game.freezed.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required final XmlElement originalEl,
    required final String nameOrCloneOf,
    required final List<String> regions,
  }) = _Game;
}
