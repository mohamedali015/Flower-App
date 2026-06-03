import '../../../../config/error_handling/result.dart';
import '../entities/auth_entity.dart';
import '../params/register_params.dart';

abstract interface class AuthRepo {
  Future<Result<AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<AuthEntity>> register({required RegisterParams params});

}
