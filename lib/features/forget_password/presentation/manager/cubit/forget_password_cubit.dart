import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../event/forget_password_event.dart';
import '../state/forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._resetPasswordUseCase,
    this._verifyResetCodeUseCase,
  ) : super(ForgetPasswordState());

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  void doEvent(ForgetPasswordEvents event) {
    switch (event) {
      case SendEmailEvent():
        {
          _sendEmail(event.email);
          break;
        }

      case VerifyOtpEvent():
        {
          _verifyOtp();
          break;
        }

      case ResetPasswordEvent():
        {
          _resetPassword();
          break;
        }
    }
  }

  Future<void> _sendEmail(String email) async {
    emit(
      state.copyWith(
        sendEmailState: BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
        ),
      ),
    );
    var result = await _forgetPasswordUseCase(email);

    switch (result) {
      case Success<String?>():
        emit(
          state.copyWith(
            sendEmailState: BaseState(
              data: result.data,
              errorMessage: null,
              isLoading: false,
              isSuccess: true,
            ),
          ),
        );
      case Failure<String?>():
        emit(
          state.copyWith(
            sendEmailState: BaseState(
              data: null,
              errorMessage: result.errorMessage,
              isLoading: false,
              isSuccess: false,
            ),
          ),
        );
    }
  }

  void _resetPassword() {}

  void _verifyOtp() {}
}
