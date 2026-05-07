import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/auth/data/mapper/auth_mapper.dart';
import 'package:flower_app/features/auth/data/model/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_source/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final SecureCache secureCache;

  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource, this.secureCache);

  @override
  Future<Result<AuthEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String gender,
  }) async {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await _authRemoteDataSource.login(
      email: email,
      password: password,
    );

    switch (response) {
      case Success<AuthResponse>():
        {
          final entity = response.data.toEntity();

          if (response.data.token != null) {
            await secureCache.saveData(
              key: CacheKeys.token,
              value: response.data.token!,
            );

            await secureCache.saveData(
              key: CacheKeys.rememberMe,
              value: rememberMe.toString(),
            );
          }

          return Success(data: entity);
        }
      case Failure<AuthResponse>():
        {
          return Failure(errorMessage: response.errorMessage);
        }
    }
  }
}
