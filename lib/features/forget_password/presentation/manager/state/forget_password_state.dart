import 'package:equatable/equatable.dart';

import '../../../../../config/base_state/base_state.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.sendEmailState = const BaseState(),
    this.resetPasswordState = const BaseState(),
    this.verifyOtpState = const BaseState(),
    this.email,
    this.remainingSeconds = 60,
    this.canResend = false,
  });

  final BaseState<String>? sendEmailState;

  final BaseState<bool>? verifyOtpState;

  final BaseState<bool>? resetPasswordState;

  final String? email;

  final int remainingSeconds;

  final bool canResend; // listen to state when timer is done

  ForgetPasswordState copyWith({
    BaseState<String>? sendEmailState,
    BaseState<bool>? verifyOtpState,
    BaseState<bool>? resetPasswordState,
    String? email,
    int? remainingSeconds,
    bool? canResend,
    bool? isResendCodeState,
    bool? isInResendCodeView,
  }) {
    return ForgetPasswordState(
      sendEmailState: sendEmailState ?? this.sendEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      email: email ?? this.email,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
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
  ];
}
