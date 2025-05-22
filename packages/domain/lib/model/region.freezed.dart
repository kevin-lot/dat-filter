// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Region {
  String get code;
  bool get isSelected;
  bool get isEmphasis;

  /// Create a copy of Region
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegionCopyWith<Region> get copyWith => _$RegionCopyWithImpl<Region>(this as Region, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Region &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.isSelected, isSelected) || other.isSelected == isSelected) &&
            (identical(other.isEmphasis, isEmphasis) || other.isEmphasis == isEmphasis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, isSelected, isEmphasis);

  @override
  String toString() {
    return 'Region(code: $code, isSelected: $isSelected, isEmphasis: $isEmphasis)';
  }
}

/// @nodoc
abstract mixin class $RegionCopyWith<$Res> {
  factory $RegionCopyWith(Region value, $Res Function(Region) _then) = _$RegionCopyWithImpl;
  @useResult
  $Res call({String code, bool isSelected, bool isEmphasis});
}

/// @nodoc
class _$RegionCopyWithImpl<$Res> implements $RegionCopyWith<$Res> {
  _$RegionCopyWithImpl(this._self, this._then);

  final Region _self;
  final $Res Function(Region) _then;

  /// Create a copy of Region
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? isSelected = null,
    Object? isEmphasis = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmphasis: null == isEmphasis
          ? _self.isEmphasis
          : isEmphasis // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _Region extends Region {
  const _Region({required this.code, required this.isSelected, this.isEmphasis = false}) : super._();

  @override
  final String code;
  @override
  final bool isSelected;
  @override
  @JsonKey()
  final bool isEmphasis;

  /// Create a copy of Region
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegionCopyWith<_Region> get copyWith => __$RegionCopyWithImpl<_Region>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Region &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.isSelected, isSelected) || other.isSelected == isSelected) &&
            (identical(other.isEmphasis, isEmphasis) || other.isEmphasis == isEmphasis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, isSelected, isEmphasis);

  @override
  String toString() {
    return 'Region(code: $code, isSelected: $isSelected, isEmphasis: $isEmphasis)';
  }
}

/// @nodoc
abstract mixin class _$RegionCopyWith<$Res> implements $RegionCopyWith<$Res> {
  factory _$RegionCopyWith(_Region value, $Res Function(_Region) _then) = __$RegionCopyWithImpl;
  @override
  @useResult
  $Res call({String code, bool isSelected, bool isEmphasis});
}

/// @nodoc
class __$RegionCopyWithImpl<$Res> implements _$RegionCopyWith<$Res> {
  __$RegionCopyWithImpl(this._self, this._then);

  final _Region _self;
  final $Res Function(_Region) _then;

  /// Create a copy of Region
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? isSelected = null,
    Object? isEmphasis = null,
  }) {
    return _then(_Region(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmphasis: null == isEmphasis
          ? _self.isEmphasis
          : isEmphasis // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
