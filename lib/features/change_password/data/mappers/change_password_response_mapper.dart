import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';

extension ChangePasswordResponseMapper on ChangePasswordResponse {
  ChangePasswordResponseEntity toEntity() {
    return ChangePasswordResponseEntity(message: message, token: token);
  }
}
