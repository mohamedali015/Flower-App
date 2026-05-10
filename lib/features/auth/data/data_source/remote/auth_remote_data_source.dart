import 'package:flower_app/features/auth/data/model/request/register_request.dart';

import '../../../../../config/error_handling/result.dart';
import '../../model/response/auth_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthResponse>> register({required RegisterRequest request});
}
