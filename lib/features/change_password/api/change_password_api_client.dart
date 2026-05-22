import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'change_password_api_client.g.dart';

@injectable
@RestApi()
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(ApiEndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest changePasswordRequest,
  );
}
