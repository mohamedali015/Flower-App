import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../../core/values/api_strings.dart';
import '../../../../../core/values/api_end_points.dart';
import '../forget_password_client.dart';

@LazySingleton(as: ForgetPasswordClient)
class FakeForgetPasswordClient implements ForgetPasswordClient {

  @override
  Future<String?> forgetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network

    // simulate error case
    if (email == "error@test.com") {
      throw Exception("Failed to send reset email");
    }

    // simulate success (usually API returns message or token)
    return "Reset code sent to $email";
  }

  @override
  Future<bool> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));

    // simulate validation error
    if (newPassword.length < 6) {
      throw Exception("Password too weak");
    }

    return true; // success
  }

  @override
  Future<bool> verifyReset(String resetCode) async {
    await Future.delayed(const Duration(seconds: 1));

    // simulate wrong code
    if (resetCode != "123456") {
      return false;
    }

    return true;
  }
}