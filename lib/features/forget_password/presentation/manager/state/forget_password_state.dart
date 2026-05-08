import '../../../../../config/base_state/base_state.dart';

class ForgetPasswordState {
  ForgetPasswordState({
    this.sendEmailState,
    this.resetPasswordState,
    this.verifyOtpState,
    this.resetCode
  });

  BaseState<String>? sendEmailState = BaseState();

  BaseState<bool>? verifyOtpState = BaseState();

  BaseState<bool>? resetPasswordState = BaseState();

  String? resetCode;

  ForgetPasswordState copyWith({
    BaseState<String>? sendEmailState,
    BaseState<bool>? verifyOtpState,
    BaseState<bool>? resetPasswordState,
    String? resetCode
  }) {
    return ForgetPasswordState(
      sendEmailState: sendEmailState ?? this.sendEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      resetCode: resetCode ?? this.resetCode
    );
  }
}
