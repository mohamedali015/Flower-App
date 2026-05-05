import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

sealed class LoginState extends Equatable {
  final bool rememberMe;

  const LoginState({this.rememberMe = false});

  @override
  List<Object> get props => [rememberMe];
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.rememberMe});

  LoginInitial copyWith({bool? rememberMe}) {
    return LoginInitial(rememberMe: rememberMe ?? this.rememberMe);
  }
}

final class LoginLoading extends LoginState {
  const LoginLoading({super.rememberMe});
}

final class LoginSuccess extends LoginState {
  final AuthEntity authEntity;

  const LoginSuccess({required this.authEntity, super.rememberMe});

  @override
  List<Object> get props => [authEntity, rememberMe];
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage, super.rememberMe});

  @override
  List<Object> get props => [errorMessage, rememberMe];
}
