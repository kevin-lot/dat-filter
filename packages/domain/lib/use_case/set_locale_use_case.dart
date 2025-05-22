import 'dart:ui' show Locale;

import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class SetLocaleUseCase implements UseCaseInterface {
  SetLocaleUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<void> call(final Locale value) async {
    return await _repository.setLocale(value);
  }
}
