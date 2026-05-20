import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/api/change_password_api_client.dart';
import 'package:flower_app/features/change_password/data/data_source/change_password_data_source.dart';
import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImpl implements ChangePasswordDataSource {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordDataSourceImpl(this._apiClient);
  @override
  Future<Result<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) {
    return executeApi(() {
      return _apiClient.changePassword(changePasswordRequest);
    });
  }
}
