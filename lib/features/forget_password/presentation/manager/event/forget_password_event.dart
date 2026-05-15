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

  VerifyOtpEvent(
    this.otp,);
}

class ResetPasswordEvent extends ForgetPasswordEvents {
  final String newPassword;

  ResetPasswordEvent({required this.newPassword});
}

class ResendCodeTimer extends ForgetPasswordEvents {}

class ResendCodeEvent extends ForgetPasswordEvents {}
