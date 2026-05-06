import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/forget_password/domain/repositories/forget_password_remote_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._forgetPasswordRemoteRepoContract);

  final ForgetPasswordRemoteRepoContract _forgetPasswordRemoteRepoContract;

  Future<Result<bool>> call({
    required String email,
    required String newPassword,
  }) async {
    var result = await _forgetPasswordRemoteRepoContract.resetPassword(
      email: email,
      newPassword: newPassword,
    );

    switch (result) {
      case Success<bool>():
        return Success<bool>(data: result.data);
      case Failure<bool>():
        return Failure(errorMessage: result.errorMessage);
    }
  }
}
