import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';

abstract interface class OccasionsRemoteDataSource {
  Future<Result<OccasionsResponse>> getOccasions();
}
