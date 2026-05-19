import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/api/logout_api_client.dart';
import 'package:flower_app/features/logout/data/data_source/logout_data_source.dart';
import 'package:flower_app/features/logout/data/models/logout_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutDataSource)
class LogoutDataSourceImpl implements LogoutDataSource {
  final LogoutApiClient _apiClient;

  LogoutDataSourceImpl(this._apiClient);
  @override
  Future<Result<LogoutResponse>> logout() {
    return executeApi<LogoutResponse>(() {
      return _apiClient.logout();
    });
  }
}
