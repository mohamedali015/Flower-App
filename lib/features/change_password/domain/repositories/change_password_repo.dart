import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';

abstract interface class ChangePasswordRepo {
  Future<Result<ChangePasswordResponseEntity>> changePassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  });
}
