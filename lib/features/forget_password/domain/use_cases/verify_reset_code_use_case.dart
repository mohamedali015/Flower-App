import 'package:flower_app/features/forget_password/domain/repositories/forget_password_remote_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';

@injectable
class VerifyResetCodeUseCase {
  VerifyResetCodeUseCase(this._forgetPasswordRemoteRepoContract);

  final ForgetPasswordRemoteRepoContract _forgetPasswordRemoteRepoContract;

  Future<Result<bool>> call({required String resetCode}) async {
    var result = await _forgetPasswordRemoteRepoContract.verifyReset(
      resetCode: resetCode,
    );
    switch (result) {
      case Success<bool>():
        return Success<bool>(data: result.data);
      case Failure<bool>():
        return Failure(errorMessage: result.errorMessage);
    }
  }
}
