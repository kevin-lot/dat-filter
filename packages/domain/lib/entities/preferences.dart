import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences.freezed.dart';

@freezed
abstract class Preferences with _$Preferences {
  const factory Preferences({
    final List<Region>? configRegions,
    final bool? configRegionsFirstMatch,
    final Locale? locale,
    final ThemeMode? themeMode,
    final Color? themeColor,
  }) = _Preferences;
}
