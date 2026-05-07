import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../forget_password_client.dart';

@LazySingleton(as: ForgetPasswordClient)
class FakeForgetPasswordClient implements ForgetPasswordClient {
  @override
  Future<String?> forgetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network

    // simulate error case
    if (email == "error@test.com") {
      throw DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(),
          data: {'message': 'Failed to send reset email'},
        ),
        requestOptions: RequestOptions(),
      );
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
      throw DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(),
          data: {'message': 'wrong code'},
        ),
        requestOptions: RequestOptions(),
      );
    }

    return true;
  }
}
