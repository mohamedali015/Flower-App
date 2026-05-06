import 'package:flower_app/config/error_handling/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/forget_password_remote_repo_contract.dart';
import '../data_sources/forget_password_remote_data_source_contract.dart';

@Injectable(as: ForgetPasswordRemoteRepoContract)
class ForgetPasswordRemoteRepoImp implements ForgetPasswordRemoteRepoContract {
  ForgetPasswordRemoteRepoImp(this._forgetPasswordRemoteDataSource);

  final ForgetPasswordRemoteDataSourceContract _forgetPasswordRemoteDataSource;

  @override
  Future<Result<String?>> forgetPassword({required String email}) async {
    var result = await _forgetPasswordRemoteDataSource.forgetPassword(
      email: email,
    );
    switch (result) {
      case Success<String?>():
        return Success(data: result.data);
      case Failure<String?>():
        return Failure(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<bool>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    var result = await _forgetPasswordRemoteDataSource.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    switch (result) {
      case Success<bool>():
        return Success<bool>(data: result.data);

      case Failure<bool>():
        return Failure<bool>(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<bool>> verifyReset({required String resetCode}) async {
    var result = await _forgetPasswordRemoteDataSource.verifyReset(
      resetCode: resetCode,
    );

    switch (result) {
      case Success<bool>():
        return Success(data: result.data);
      case Failure<bool>():
        return Failure(errorMessage: result.errorMessage);
    }
  }
}
