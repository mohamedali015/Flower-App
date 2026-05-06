import '../../../../../config/base_state/base_state.dart';

class ForgetPasswordState {
  ForgetPasswordState({
    this.sendEmailState,
    this.resetPasswordState,
    this.verifyOtpState,
  });

  BaseState<String>? sendEmailState = BaseState();

  BaseState<bool>? verifyOtpState = BaseState();

  BaseState<bool>? resetPasswordState = BaseState();

  ForgetPasswordState copyWith({
    BaseState<String>? sendEmailState,
    BaseState<bool>? verifyOtpState,
    BaseState<bool>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      sendEmailState: sendEmailState ?? this.sendEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
