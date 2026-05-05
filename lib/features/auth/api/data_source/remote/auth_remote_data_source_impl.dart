import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/features/auth/data/model/request/register_request.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../data/data_source/remote/auth_remote_data_source.dart';
import '../../../data/model/response/auth_response.dart';
import '../../auth_api_client.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String gender,
  }) {
    return executeApi(() async {
      final request = RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        rePassword: confirmPassword,
        phone: phone,
        gender: gender,
      );
      return await _apiClient.register(request);
    });
  }
}
