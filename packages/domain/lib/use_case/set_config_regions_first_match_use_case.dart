import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class SetConfigRegionsFirstMatchUseCase implements UseCaseInterface {
  SetConfigRegionsFirstMatchUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  // ignore: avoid_positional_boolean_parameters
  Future<void> call(final bool value) async {
    return await _repository.setConfigRegionsFirstMatch(value);
  }
}
