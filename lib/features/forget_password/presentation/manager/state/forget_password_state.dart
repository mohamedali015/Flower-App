import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';

class ForgetPasswordState extends Equatable {
  ForgetPasswordState({
    this.sendEmailState = const BaseState(),
    this.resetPasswordState = const BaseState(),
    this.verifyOtpState = const BaseState(),
    this.email,
    this.remainingSeconds = 60,
    this.canResend = false,
    this.isResendCodeState = false,
  });

  final BaseState<String>? sendEmailState;

  final BaseState<bool>? verifyOtpState;

  final BaseState<bool>? resetPasswordState;

  String? email;

  final int remainingSeconds;

  final bool canResend; // listen to state when timer is done

  bool
  isResendCodeState; // listen to the state when in ForgetPasswordView or in ViewOtp View

  ForgetPasswordState copyWith({
    BaseState<String>? sendEmailState,
    BaseState<bool>? verifyOtpState,
    BaseState<bool>? resetPasswordState,
    String? email,
    int? remainingSeconds,
    bool? canResend,
    bool? isResendCodeState,
  }) {
    return ForgetPasswordState(
      sendEmailState: sendEmailState ?? this.sendEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      email: email ?? this.email,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
      isResendCodeState: isResendCodeState ?? this.isResendCodeState,
    );
  }

  @override
  List<Object?> get props => [
    sendEmailState,
    verifyOtpState,
    resetPasswordState,
    email,
    remainingSeconds,
    canResend,
    isResendCodeState,
  ];
}
