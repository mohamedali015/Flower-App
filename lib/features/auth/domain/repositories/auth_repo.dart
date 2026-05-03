import '../../../../config/error_handling/result.dart';
import '../entities/auth_entity.dart';

abstract interface class AuthRepo {
  Future<Result<AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<AuthEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String gender,
  });
}
