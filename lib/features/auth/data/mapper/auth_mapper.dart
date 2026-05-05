import 'package:flower_app/features/auth/data/mapper/user_mapper.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

extension AuthMapper on AuthResponse {
  AuthEntity toEntity() {
    return AuthEntity(message: message, user: user?.toEntity());
  }
}
