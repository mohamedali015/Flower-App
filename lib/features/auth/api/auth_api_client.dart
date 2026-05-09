import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';
import '../../../core/values/api_strings.dart';
import '../data/model/request/login_request.dart';
import '../data/model/request/register_request.dart';
import '../data/model/response/auth_response.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  ////////////////// Register //////////////////

  @POST(ApiEndPoints.register)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> register(@Body() RegisterRequest request);

  ////////////////// Login //////////////////

  @POST(ApiEndPoints.login)
  @Extra({ApiStrings.requireAuth: false})
  Future<AuthResponse> login(@Body() LoginRequest login);
}
