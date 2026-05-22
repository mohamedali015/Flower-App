import '../../../../error_handling/result.dart';
import '../../models/responses/get_user_response/get_user_data_response.dart';

abstract interface class UserRemoteDataSource {
  Future<Result<GetUserDataResponse>> getUserData();
  // Future<Result<Map<String,String>>> logout();
}
