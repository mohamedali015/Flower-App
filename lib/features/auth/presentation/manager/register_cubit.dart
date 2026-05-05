import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:flower_app/features/auth/presentation/manager/register_events.dart';
import 'package:flower_app/features/auth/presentation/manager/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterState());

  final RegisterUseCase _registerUseCase;

  void doEvents(RegisterEvents event) {
    switch (event) {
      case SubmitRegisterEvent():
        _submitRegister(event);

      case SelectGenderEvent():
        emit(state.copyWith(genderParam: event.gender));

      case SubmitPressedEvent():
        emit(state.copyWith(isSubmittedParam: true));

      case PasswordVisibilityEvent():
        emit(state.copyWith(isPasswordHiddenParam: !state.isPasswordHidden));

      case ConfirmPasswordVisibilityEvent():
        emit(
          state.copyWith(
            isConfirmPasswordHiddenParam: !state.isConfirmPasswordHidden,
          ),
        );
    }
  }

  Future<void> _submitRegister(SubmitRegisterEvent event) async {
    emit(
      state.copyWith(
        registerStateParam: state.registerState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _registerUseCase.call(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
      phone: event.phone,
      gender: event.gender,
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }
}
