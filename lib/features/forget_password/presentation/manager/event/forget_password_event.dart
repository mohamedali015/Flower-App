sealed class ForgetPasswordEvents {}

class SendEmailEvent extends ForgetPasswordEvents {
  final String email;

  SendEmailEvent(this.email);
}

class VerifyOtpEvent extends ForgetPasswordEvents {}

class ResetPasswordEvent extends ForgetPasswordEvents {}
