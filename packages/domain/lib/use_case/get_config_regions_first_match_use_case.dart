import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class GetConfigRegionsFirstMatchUseCase implements UseCaseInterface {
  GetConfigRegionsFirstMatchUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<bool?> call() async {
    return await _repository.getConfigRegionsFirstMatch();
  }
}
