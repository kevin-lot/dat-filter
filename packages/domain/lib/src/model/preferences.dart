import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences.freezed.dart';

@freezed
abstract class Preferences with _$Preferences {
  const factory Preferences({
    final List<String>? configRegions,
    final bool? configRegionsFirstMatch,
    final String? language,
    final ThemeMode? themeMode,
    final Color? themeColor,
  }) = _Preferences;
}
