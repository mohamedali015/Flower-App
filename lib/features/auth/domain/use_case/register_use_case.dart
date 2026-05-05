import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  Future<Result<AuthEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String gender,
  }) async {
    return await _authRepo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      gender: gender,
    );
  }
}
