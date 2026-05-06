import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_strings.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/values/api_end_points.dart';

part 'forget_password_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class ForgetPasswordClient {
  @factoryMethod
  factory ForgetPasswordClient(Dio dio) = _ForgetPasswordClient;

  @POST(ApiEndPoints.forgetPassword)
  Future<bool> forgetPassword(@Field(ApiStrings.email) String email);

  @PUT(ApiEndPoints.resetPassword)
  Future<bool> resetPassword(
    @Field(ApiStrings.email) String email,
    @Field(ApiStrings.newPassword) String newPassword,
  );

  @POST(ApiEndPoints.verifyResetCode)
  Future<bool> verifyReset(@Field(ApiStrings.resetCode) String resetCode);
}
