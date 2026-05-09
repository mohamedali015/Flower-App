import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  const AuthEntity({required this.message, required this.user});

  final String message;
  final UserEntity user;

  @override
  List<Object?> get props => [message, user];
}
