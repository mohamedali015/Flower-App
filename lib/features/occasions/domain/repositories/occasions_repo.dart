import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';

abstract interface class OccasionsRepo {
  Future<Result<List<OccasionEntity>>> getOccasions();
}
