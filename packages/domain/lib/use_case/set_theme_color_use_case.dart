import 'dart:ui' show Color;

import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class SetThemeColorUseCase implements UseCaseInterface {
  SetThemeColorUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<void> call(final Color value) async {
    return await _repository.setThemeColor(value);
  }
}
