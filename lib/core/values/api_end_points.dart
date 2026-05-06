abstract class ApiEndPoints {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";

  static const String login = '/auth/signin';
  static const String register = '/auth/signup';
  static const String forgetPassword = "/auth/forgotPassword";
  static const String resetPassword = "/auth/resetPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
}
