import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';

abstract interface class ChangePasswordDataSource {
  Future<Result<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  });
}
