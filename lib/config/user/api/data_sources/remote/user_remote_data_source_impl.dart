import 'package:injectable/injectable.dart';
import '../../../../error_handling/execute_api.dart';
import '../../../../error_handling/result.dart';
import '../../../data/data_sources/remote/user_remote_data_source.dart';
import '../../../data/models/responses/get_user_response/get_user_data_response.dart';
import '../../user_api_client/user_api_client.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApiClient _apiClient;

  UserRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<GetUserDataResponse>> getUserData() async {
    return executeApi(() async {
      var response = await _apiClient.getUserData();
      return response;
    });
  }
}
