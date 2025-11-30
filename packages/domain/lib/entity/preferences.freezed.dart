// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Preferences {
  List<Region>? get configRegions;
  bool? get configRegionsFirstMatch;
  Locale? get locale;
  ThemeMode? get themeMode;
  Color? get themeColor;

  /// Create a copy of Preferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreferencesCopyWith<Preferences> get copyWith =>
      _$PreferencesCopyWithImpl<Preferences>(this as Preferences, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Preferences &&
            const DeepCollectionEquality()
                .equals(other.configRegions, configRegions) &&
            (identical(
                    other.configRegionsFirstMatch, configRegionsFirstMatch) ||
                other.configRegionsFirstMatch == configRegionsFirstMatch) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(configRegions),
      configRegionsFirstMatch,
      locale,
      themeMode,
      themeColor);

  @override
  String toString() {
    return 'Preferences(configRegions: $configRegions, configRegionsFirstMatch: $configRegionsFirstMatch, locale: $locale, themeMode: $themeMode, themeColor: $themeColor)';
  }
}

/// @nodoc
abstract mixin class $PreferencesCopyWith<$Res> {
  factory $PreferencesCopyWith(
          Preferences value, $Res Function(Preferences) _then) =
      _$PreferencesCopyWithImpl;
  @useResult
  $Res call(
      {List<Region>? configRegions,
      bool? configRegionsFirstMatch,
      Locale? locale,
      ThemeMode? themeMode,
      Color? themeColor});
}

/// @nodoc
class _$PreferencesCopyWithImpl<$Res> implements $PreferencesCopyWith<$Res> {
  _$PreferencesCopyWithImpl(this._self, this._then);

  final Preferences _self;
  final $Res Function(Preferences) _then;

  /// Create a copy of Preferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? configRegions = freezed,
    Object? configRegionsFirstMatch = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? themeColor = freezed,
  }) {
    return _then(_self.copyWith(
      configRegions: freezed == configRegions
          ? _self.configRegions
          : configRegions // ignore: cast_nullable_to_non_nullable
              as List<Region>?,
      configRegionsFirstMatch: freezed == configRegionsFirstMatch
          ? _self.configRegionsFirstMatch
          : configRegionsFirstMatch // ignore: cast_nullable_to_non_nullable
              as bool?,
      locale: freezed == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: freezed == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      themeColor: freezed == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Preferences].
extension PreferencesPatterns on Preferences {
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
    TResult Function(_Preferences value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Preferences() when $default != null:
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
    TResult Function(_Preferences value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Preferences():
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
    TResult? Function(_Preferences value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Preferences() when $default != null:
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
    TResult Function(List<Region>? configRegions, bool? configRegionsFirstMatch,
            Locale? locale, ThemeMode? themeMode, Color? themeColor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Preferences() when $default != null:
        return $default(_that.configRegions, _that.configRegionsFirstMatch,
            _that.locale, _that.themeMode, _that.themeColor);
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
    TResult Function(List<Region>? configRegions, bool? configRegionsFirstMatch,
            Locale? locale, ThemeMode? themeMode, Color? themeColor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Preferences():
        return $default(_that.configRegions, _that.configRegionsFirstMatch,
            _that.locale, _that.themeMode, _that.themeColor);
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
            List<Region>? configRegions,
            bool? configRegionsFirstMatch,
            Locale? locale,
            ThemeMode? themeMode,
            Color? themeColor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Preferences() when $default != null:
        return $default(_that.configRegions, _that.configRegionsFirstMatch,
            _that.locale, _that.themeMode, _that.themeColor);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Preferences implements Preferences {
  const _Preferences(
      {final List<Region>? configRegions,
      this.configRegionsFirstMatch,
      this.locale,
      this.themeMode,
      this.themeColor})
      : _configRegions = configRegions;

  final List<Region>? _configRegions;
  @override
  List<Region>? get configRegions {
    final value = _configRegions;
    if (value == null) return null;
    if (_configRegions is EqualUnmodifiableListView) return _configRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? configRegionsFirstMatch;
  @override
  final Locale? locale;
  @override
  final ThemeMode? themeMode;
  @override
  final Color? themeColor;

  /// Create a copy of Preferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PreferencesCopyWith<_Preferences> get copyWith =>
      __$PreferencesCopyWithImpl<_Preferences>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Preferences &&
            const DeepCollectionEquality()
                .equals(other._configRegions, _configRegions) &&
            (identical(
                    other.configRegionsFirstMatch, configRegionsFirstMatch) ||
                other.configRegionsFirstMatch == configRegionsFirstMatch) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_configRegions),
      configRegionsFirstMatch,
      locale,
      themeMode,
      themeColor);

  @override
  String toString() {
    return 'Preferences(configRegions: $configRegions, configRegionsFirstMatch: $configRegionsFirstMatch, locale: $locale, themeMode: $themeMode, themeColor: $themeColor)';
  }
}

/// @nodoc
abstract mixin class _$PreferencesCopyWith<$Res>
    implements $PreferencesCopyWith<$Res> {
  factory _$PreferencesCopyWith(
          _Preferences value, $Res Function(_Preferences) _then) =
      __$PreferencesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Region>? configRegions,
      bool? configRegionsFirstMatch,
      Locale? locale,
      ThemeMode? themeMode,
      Color? themeColor});
}

/// @nodoc
class __$PreferencesCopyWithImpl<$Res> implements _$PreferencesCopyWith<$Res> {
  __$PreferencesCopyWithImpl(this._self, this._then);

  final _Preferences _self;
  final $Res Function(_Preferences) _then;

  /// Create a copy of Preferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? configRegions = freezed,
    Object? configRegionsFirstMatch = freezed,
    Object? locale = freezed,
    Object? themeMode = freezed,
    Object? themeColor = freezed,
  }) {
    return _then(_Preferences(
      configRegions: freezed == configRegions
          ? _self._configRegions
          : configRegions // ignore: cast_nullable_to_non_nullable
              as List<Region>?,
      configRegionsFirstMatch: freezed == configRegionsFirstMatch
          ? _self.configRegionsFirstMatch
          : configRegionsFirstMatch // ignore: cast_nullable_to_non_nullable
              as bool?,
      locale: freezed == locale
          ? _self.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      themeMode: freezed == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      themeColor: freezed == themeColor
          ? _self.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

// dart format on
