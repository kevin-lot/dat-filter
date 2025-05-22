import 'package:domain/entity/region.dart';
import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class GetConfigRegionsUseCase implements UseCaseInterface {
  GetConfigRegionsUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<List<Region>?> call() async {
    return await _repository.getConfigRegions();
  }
}
