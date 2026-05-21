import 'dart:io';

import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

import '../../../../config/error_handling/result.dart';
import '../params/edit_profile_params.dart';

abstract class EditProfileRepo {
  Future<Result<AuthEntity>> editProfile({required EditProfileParams params});

  Future<Result<bool>> uploadPhoto({required File image});
}
