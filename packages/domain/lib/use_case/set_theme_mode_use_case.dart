import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';
import 'package:flutter/material.dart' show ThemeMode;

class SetThemeModeUseCase implements UseCaseInterface {
  SetThemeModeUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<void> call(final ThemeMode value) async {
    return await _repository.setThemeMode(value);
  }
}
