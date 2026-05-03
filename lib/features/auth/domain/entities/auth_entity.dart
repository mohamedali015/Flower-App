import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  const AuthEntity({this.message, this.token, this.user});

  final String? message;
  final String? token;
  final UserEntity? user;

  @override
  List<Object?> get props => [message, token, user];
}
