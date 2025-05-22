import 'package:domain/entity/region.dart' show Region;
import 'package:domain/repository/preferences_repository_interface.dart';
import 'package:domain/use_case/use_case_interface.dart';

class SetConfigRegionsUseCase implements UseCaseInterface {
  SetConfigRegionsUseCase({
    required final PreferencesRepositoryInterface repository,
  }) : _repository = repository;

  final PreferencesRepositoryInterface _repository;

  Future<void> call(final List<Region> value) async {
    return await _repository.setConfigRegions(value);
  }
}
