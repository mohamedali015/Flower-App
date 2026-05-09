import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

sealed class ForgetPasswordEvents {}

class SendEmailEvent extends ForgetPasswordEvents {
  final String email;

  SendEmailEvent(this.email);
}

class VerifyOtpEvent extends ForgetPasswordEvents {
  final String otp;
  final TextEditingController otpController;

  final StreamController<ErrorAnimationType> errorController;

  VerifyOtpEvent(
    this.otp, {
    required this.otpController,
    required this.errorController,
  });
}

class ResetPasswordEvent extends ForgetPasswordEvents {
  final String newPassword;

  ResetPasswordEvent({required this.newPassword});
}

class ResendCodeTimer extends ForgetPasswordEvents {}

class ResendCodeEvent extends ForgetPasswordEvents {}
