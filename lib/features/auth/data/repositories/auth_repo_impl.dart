import 'package:flower_app/features/auth/data/mapper/auth_mapper.dart';
import 'package:flower_app/features/auth/data/mapper/register_params_mapper.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/params/register_params.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_source/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<Result<AuthEntity>> register({required RegisterParams params}) async {
    final response = await _authRemoteDataSource.register(
      request: params.toRequest(),
    );

    switch (response) {
      case Success<AuthResponse>():
        {
          return Success<AuthEntity>(data: response.data.toEntity());
        }
      case Failure<AuthResponse>():
        {
          return Failure<AuthEntity>(errorMessage: response.errorMessage);
        }
    }
  }

  @override
  Future<Result<AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}
