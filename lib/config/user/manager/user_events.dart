import '../domain/entities/user_entity.dart';

sealed class UserEvents {}

class GetUserDataEvent extends UserEvents {}

class SetUserDataEvent extends UserEvents {
  final UserEntity user;

  SetUserDataEvent({required this.user});
}

class UnauthorizedUserEvent extends UserEvents {}

class ResetUnauthorizedEvent extends UserEvents {}

// class LogoutUserEvent extends UserEvents {}
