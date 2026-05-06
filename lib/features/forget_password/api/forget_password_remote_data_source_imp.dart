import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/forget_password/api/client/forget_password_client.dart';
import 'package:injectable/injectable.dart';

import '../data/data_sources/forget_password_remote_data_source_contract.dart';

@Injectable(as: ForgetPasswordRemoteDataSourceContract)
class ForgetPasswordRemoteDataSourceImp
    implements ForgetPasswordRemoteDataSourceContract {
  ForgetPasswordRemoteDataSourceImp(this._forgetPasswordClient);

  final ForgetPasswordClient _forgetPasswordClient;

  @override
  Future<Result<bool>> forgetPassword({required String email}) {
    return executeApi<bool>(() {
      return _forgetPasswordClient.forgetPassword(email);
    });
  }

  @override
  Future<Result<bool>> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return executeApi(
      () => _forgetPasswordClient.resetPassword(email, newPassword),
    );
  }

  @override
  Future<Result<bool>> verifyReset({required String resetCode}) {
    return executeApi(() => _forgetPasswordClient.verifyReset(resetCode));
  }
}
