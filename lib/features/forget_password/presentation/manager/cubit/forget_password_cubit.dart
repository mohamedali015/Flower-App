import 'dart:async';

import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          _verifyOtp(
            event.otp,
            otpController: event.otpController,
            errorController: event.errorController,
          );
          break;
        }

      case ResetPasswordEvent():
        {
          _resetPassword(event);
          break;
        }
      case ResendCodeTimer():
        {
          _startResendTimer();
          break;
        }

      case ResendCodeEvent():
        {
          _resendCode();
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
          isSuccess: false,
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

  void _resetPassword(ResetPasswordEvent event) async {
    emit(
      state.copyWith(
        resetPasswordState: BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
          isSuccess: false,
        ),
      ),
    );
    var result = await _resetPasswordUseCase(
      email: state.email!,
      newPassword: event.newPassword,
    );

    switch (result) {
      case Success<bool>():
        emit(
          state.copyWith(
            sendEmailState: BaseState(
              errorMessage: null,
              isLoading: false,
              isSuccess: true,
            ),
          ),
        );
      case Failure<bool>():
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

  Future<void> _verifyOtp(
    String otp, {
    required TextEditingController otpController,
    required StreamController<ErrorAnimationType> errorController,
  }) async {
    emit(
      state.copyWith(
        verifyOtpState: BaseState(
          isLoading: true,
          errorMessage: null,
          data: null,
          isSuccess: false,
        ),
      ),
    );
    var result = await _verifyResetCodeUseCase(resetCode: otp);
    switch (result) {
      case Success<bool>():
        emit(
          state.copyWith(
            verifyOtpState: BaseState(
              isSuccess: true,
              isLoading: false,
              data: result.data,
              errorMessage: null,
            ),
          ),
        );
      case Failure<bool>():
        {
          errorController.add(ErrorAnimationType.shake);
          otpController.clear();
          emit(
            state.copyWith(
              verifyOtpState: BaseState(
                isSuccess: false,
                isLoading: false,
                data: null,
                errorMessage: result.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Timer? _timer;

  void _startResendTimer() {
    emit(state.copyWith(remainingSeconds: 30, canResend: false));

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = state.remainingSeconds - 1;

      if (seconds <= 0) {
        timer.cancel();

        emit(state.copyWith(remainingSeconds: 0, canResend: true));
      } else {
        emit(state.copyWith(remainingSeconds: seconds));
      }
    });
  }

  Future<void> _resendCode() async {
    if (!state.canResend) return;
    emit(
      state.copyWith(
        sendEmailState: BaseState(
          data: null,
          errorMessage: null,
          isLoading: true,
          isSuccess: false,
        ),
        isResendCodeState: true,
      ),
    );
    var result = await _forgetPasswordUseCase(state.email!);
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
            isResendCodeState: true,
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
            isResendCodeState: true,
          ),
        );
    }
    _startResendTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
