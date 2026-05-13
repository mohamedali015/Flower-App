import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'occasions_api_client.g.dart';

@injectable
@RestApi()
abstract class OccasionsApiClient {
  @factoryMethod
  factory OccasionsApiClient(Dio dio) = _OccasionsApiClient;

  @GET(ApiEndPoints.getOccasions)
  Future<OccasionsResponse> getOccasions();
}
