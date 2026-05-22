import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/features/logout/home/data/model/home_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'home_api_client.g.dart';

@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndPoints.home)
  Future<HomeResponse> getHome();
}
