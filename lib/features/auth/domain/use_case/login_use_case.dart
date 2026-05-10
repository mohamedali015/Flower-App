import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<Result<AuthEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return _authRepo.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
