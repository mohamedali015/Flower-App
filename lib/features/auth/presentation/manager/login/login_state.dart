import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

abstract class LoginState extends Equatable {
  final bool rememberMe;

  const LoginState({this.rememberMe = false});

  LoginState copyWith({bool? rememberMe});

  @override
  List<Object> get props => [rememberMe];
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.rememberMe});

  @override
  LoginInitial copyWith({bool? rememberMe}) {
    return LoginInitial(rememberMe: rememberMe ?? this.rememberMe);
  }
}

final class LoginLoading extends LoginState {
  const LoginLoading({super.rememberMe});

  @override
  LoginLoading copyWith({bool? rememberMe}) {
    return LoginLoading(rememberMe: rememberMe ?? this.rememberMe);
  }
}

final class LoginSuccess extends LoginState {
  final AuthEntity authEntity;

  const LoginSuccess({required this.authEntity, super.rememberMe});

  @override
  LoginSuccess copyWith({bool? rememberMe, AuthEntity? authEntity}) {
    return LoginSuccess(
      authEntity: authEntity ?? this.authEntity,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [authEntity, rememberMe];
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage, super.rememberMe});

  @override
  LoginFailure copyWith({bool? rememberMe, String? errorMessage}) {
    return LoginFailure(
      errorMessage: errorMessage ?? this.errorMessage,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [errorMessage, rememberMe];
}
