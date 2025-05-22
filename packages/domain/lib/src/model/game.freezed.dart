// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Game {
  XmlElement get originalEl;
  String get nameOrCloneOf;
  List<String> get regions;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Game &&
            (identical(other.originalEl, originalEl) || other.originalEl == originalEl) &&
            (identical(other.nameOrCloneOf, nameOrCloneOf) || other.nameOrCloneOf == nameOrCloneOf) &&
            const DeepCollectionEquality().equals(other.regions, regions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, originalEl, nameOrCloneOf, const DeepCollectionEquality().hash(regions));

  @override
  String toString() {
    return 'Game(originalEl: $originalEl, nameOrCloneOf: $nameOrCloneOf, regions: $regions)';
  }
}

/// @nodoc
abstract mixin class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
  @useResult
  $Res call({XmlElement originalEl, String nameOrCloneOf, List<String> regions});
}

/// @nodoc
class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalEl = null,
    Object? nameOrCloneOf = null,
    Object? regions = null,
  }) {
    return _then(_self.copyWith(
      originalEl: null == originalEl
          ? _self.originalEl
          : originalEl // ignore: cast_nullable_to_non_nullable
              as XmlElement,
      nameOrCloneOf: null == nameOrCloneOf
          ? _self.nameOrCloneOf
          : nameOrCloneOf // ignore: cast_nullable_to_non_nullable
              as String,
      regions: null == regions
          ? _self.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _Game implements Game {
  const _Game({required this.originalEl, required this.nameOrCloneOf, required final List<String> regions})
      : _regions = regions;

  @override
  final XmlElement originalEl;
  @override
  final String nameOrCloneOf;
  final List<String> _regions;
  @override
  List<String> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Game &&
            (identical(other.originalEl, originalEl) || other.originalEl == originalEl) &&
            (identical(other.nameOrCloneOf, nameOrCloneOf) || other.nameOrCloneOf == nameOrCloneOf) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, originalEl, nameOrCloneOf, const DeepCollectionEquality().hash(_regions));

  @override
  String toString() {
    return 'Game(originalEl: $originalEl, nameOrCloneOf: $nameOrCloneOf, regions: $regions)';
  }
}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
  @override
  @useResult
  $Res call({XmlElement originalEl, String nameOrCloneOf, List<String> regions});
}

/// @nodoc
class __$GameCopyWithImpl<$Res> implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? originalEl = null,
    Object? nameOrCloneOf = null,
    Object? regions = null,
  }) {
    return _then(_Game(
      originalEl: null == originalEl
          ? _self.originalEl
          : originalEl // ignore: cast_nullable_to_non_nullable
              as XmlElement,
      nameOrCloneOf: null == nameOrCloneOf
          ? _self.nameOrCloneOf
          : nameOrCloneOf // ignore: cast_nullable_to_non_nullable
              as String,
      regions: null == regions
          ? _self._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
