import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasions/domain/repositories/occasions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final OccasionsRepo _repo;

  GetOccasionsUseCase(this._repo);

  Future<Result<List<OccasionEntity>>> call() {
    return _repo.getOccasions();
  }
}
