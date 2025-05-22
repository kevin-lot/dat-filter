import 'dart:ui' show Color;

import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class GetThemeModeUseCase implements UseCaseInterface {
  GetThemeModeUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<Color?> call() async {
    return await _repository.getThemeColor();
  }
}
