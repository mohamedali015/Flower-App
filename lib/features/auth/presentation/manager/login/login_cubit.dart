import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_event.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  void doEvents(LoginEvents event) {
    switch (event) {
      case LoginSubmitEvent():
        _login(event);
        break;
      case LoginRememberMeChangedEvent():
        _changeRememberMe(event.rememberMe);
    }
  }

  void _changeRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> _login(LoginSubmitEvent event) async {
    emit(LoginLoading(rememberMe: event.rememberMe));

    final result = await _loginUseCase.call(
      email: event.email,
      password: event.password,
      rememberMe: event.rememberMe,
    );

    switch (result) {
      case Success<AuthEntity>():
        emit(
          LoginSuccess(authEntity: result.data, rememberMe: event.rememberMe),
        );
        break;

      case Failure<AuthEntity>():
        emit(
          LoginFailure(
            errorMessage: result.errorMessage,
            rememberMe: event.rememberMe,
          ),
        );
        break;
    }
  }
}
