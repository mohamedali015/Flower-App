import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/core/values/api_strings.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../data/models/remote/open_route_response.dart';

part 'open_route_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPoints.openRouteBaseUrl)
abstract class OpenRouteApiClient {
  @factoryMethod
  factory OpenRouteApiClient(Dio dio) = _OpenRouteApiClient;

  @GET(ApiEndPoints.openRouteDrivingCar)
  Future<OpenRouteResponse> getRoute({
    @Query(ApiStrings.apiKey) required String apiKey,
    @Query(ApiStrings.start) required String start, // "lng,lat"
    @Query(ApiStrings.end) required String end, // "lng,lat"
  });
}
