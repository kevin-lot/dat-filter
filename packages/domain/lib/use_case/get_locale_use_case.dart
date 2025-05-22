import 'dart:ui' show Locale;

import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class GetLocaleUseCase implements UseCaseInterface {
  GetLocaleUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<Locale?> call() async {
    return await _repository.getLocale();
  }
}
