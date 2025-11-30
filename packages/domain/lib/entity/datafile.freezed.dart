// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datafile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Datafile {
  GamesByName get gamesByName;
  XmlElement get header;
  int get originalGamesCount;

  /// Create a copy of Datafile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatafileCopyWith<Datafile> get copyWith =>
      _$DatafileCopyWithImpl<Datafile>(this as Datafile, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Datafile &&
            const DeepCollectionEquality()
                .equals(other.gamesByName, gamesByName) &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.originalGamesCount, originalGamesCount) ||
                other.originalGamesCount == originalGamesCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gamesByName),
      header,
      originalGamesCount);

  @override
  String toString() {
    return 'Datafile(gamesByName: $gamesByName, header: $header, originalGamesCount: $originalGamesCount)';
  }
}

/// @nodoc
abstract mixin class $DatafileCopyWith<$Res> {
  factory $DatafileCopyWith(Datafile value, $Res Function(Datafile) _then) =
      _$DatafileCopyWithImpl;
  @useResult
  $Res call(
      {GamesByName gamesByName, XmlElement header, int originalGamesCount});
}

/// @nodoc
class _$DatafileCopyWithImpl<$Res> implements $DatafileCopyWith<$Res> {
  _$DatafileCopyWithImpl(this._self, this._then);

  final Datafile _self;
  final $Res Function(Datafile) _then;

  /// Create a copy of Datafile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamesByName = null,
    Object? header = null,
    Object? originalGamesCount = null,
  }) {
    return _then(_self.copyWith(
      gamesByName: null == gamesByName
          ? _self.gamesByName
          : gamesByName // ignore: cast_nullable_to_non_nullable
              as GamesByName,
      header: null == header
          ? _self.header
          : header // ignore: cast_nullable_to_non_nullable
              as XmlElement,
      originalGamesCount: null == originalGamesCount
          ? _self.originalGamesCount
          : originalGamesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Datafile].
extension DatafilePatterns on Datafile {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Datafile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Datafile() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Datafile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Datafile():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Datafile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Datafile() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            GamesByName gamesByName, XmlElement header, int originalGamesCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Datafile() when $default != null:
        return $default(
            _that.gamesByName, _that.header, _that.originalGamesCount);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            GamesByName gamesByName, XmlElement header, int originalGamesCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Datafile():
        return $default(
            _that.gamesByName, _that.header, _that.originalGamesCount);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            GamesByName gamesByName, XmlElement header, int originalGamesCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Datafile() when $default != null:
        return $default(
            _that.gamesByName, _that.header, _that.originalGamesCount);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Datafile implements Datafile {
  const _Datafile(
      {required final GamesByName gamesByName,
      required this.header,
      required this.originalGamesCount})
      : _gamesByName = gamesByName;

  final GamesByName _gamesByName;
  @override
  GamesByName get gamesByName {
    if (_gamesByName is EqualUnmodifiableMapView) return _gamesByName;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_gamesByName);
  }

  @override
  final XmlElement header;
  @override
  final int originalGamesCount;

  /// Create a copy of Datafile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DatafileCopyWith<_Datafile> get copyWith =>
      __$DatafileCopyWithImpl<_Datafile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Datafile &&
            const DeepCollectionEquality()
                .equals(other._gamesByName, _gamesByName) &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.originalGamesCount, originalGamesCount) ||
                other.originalGamesCount == originalGamesCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_gamesByName),
      header,
      originalGamesCount);

  @override
  String toString() {
    return 'Datafile(gamesByName: $gamesByName, header: $header, originalGamesCount: $originalGamesCount)';
  }
}

/// @nodoc
abstract mixin class _$DatafileCopyWith<$Res>
    implements $DatafileCopyWith<$Res> {
  factory _$DatafileCopyWith(_Datafile value, $Res Function(_Datafile) _then) =
      __$DatafileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GamesByName gamesByName, XmlElement header, int originalGamesCount});
}

/// @nodoc
class __$DatafileCopyWithImpl<$Res> implements _$DatafileCopyWith<$Res> {
  __$DatafileCopyWithImpl(this._self, this._then);

  final _Datafile _self;
  final $Res Function(_Datafile) _then;

  /// Create a copy of Datafile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? gamesByName = null,
    Object? header = null,
    Object? originalGamesCount = null,
  }) {
    return _then(_Datafile(
      gamesByName: null == gamesByName
          ? _self._gamesByName
          : gamesByName // ignore: cast_nullable_to_non_nullable
              as GamesByName,
      header: null == header
          ? _self.header
          : header // ignore: cast_nullable_to_non_nullable
              as XmlElement,
      originalGamesCount: null == originalGamesCount
          ? _self.originalGamesCount
          : originalGamesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
