import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/values/api_end_points.dart';
import '../../data/models/responses/get_user_response/get_user_data_response.dart';

part 'user_api_client.g.dart';

@injectable
@RestApi()
abstract class UserApiClient {
  @factoryMethod
  factory UserApiClient(Dio dio) = _UserApiClient;

  @GET(ApiEndPoints.getUserData)
  Future<GetUserDataResponse> getUserData();
}
