import 'dart:io';

import 'package:flower_app/config/user/domain/entities/user_entity.dart';

sealed class EditProfileEvents {}

class EditProfileEvent extends EditProfileEvents {
  final String firstName;

  final String lastName;

  final String email;

  final String phone;

  EditProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}

class UploadProfileImageEvent extends EditProfileEvents {
  final File image;

  UploadProfileImageEvent({required this.image});
}

class CheckChangesEvent extends EditProfileEvents {
  final UserEntity user;

  final String firstName;

  final String lastName;

  final String email;

  final String phone;

  CheckChangesEvent({
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}
