import 'package:flower_app/config/user/data/mapper/user_mapper.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/data/model/response/edit_profile_response.dart';

import '../../../../config/user/domain/entities/user_entity.dart';

extension EditProfileResponseMapper on EditProfileResponse {
  AuthEntity toEntity() {
    return AuthEntity(
      message: message ?? '',
      user: user?.toEntity() ?? UserEntity.empty(),
    );
  }
}
