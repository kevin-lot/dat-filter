import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';
import 'package:flutter/material.dart' show ThemeMode;

class GetThemeModeUseCase implements UseCaseInterface {
  GetThemeModeUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<ThemeMode> call() async {
    return await _repository.getThemeMode();
  }
}
