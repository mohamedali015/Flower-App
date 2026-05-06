import '../../../../config/error_handling/result.dart';

abstract interface class ForgetPasswordRemoteDataSourceContract {

  Future<Result<bool>> forgetPassword({required String email});

  Future<Result<bool>> resetPassword({required String email , required String newPassword});

  Future<Result<bool>> verifyReset({required String resetCode});
}
