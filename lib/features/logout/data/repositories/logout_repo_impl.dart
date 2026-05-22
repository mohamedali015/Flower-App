import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/logout/data/data_source/logout_data_source.dart';
import 'package:flower_app/features/logout/data/models/logout_response.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flower_app/features/logout/domain/repositories/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImpl implements LogoutRepo {
  final LogoutDataSource _logoutDataSource;
  final SecureCache _secureCache;

  LogoutRepoImpl(this._logoutDataSource, this._secureCache);

  @override
  Future<Result<LogoutResponseEntity>> logout() async {
    final response = await _logoutDataSource.logout();

    switch (response) {
      case Success<LogoutResponse>():
        await _secureCache.removeData(key: CacheKeys.token);
        await _secureCache.removeData(key: CacheKeys.rememberMe);

        return Success<LogoutResponseEntity>(data: response.data.toEntity());
      case Failure<LogoutResponse>():
        return Failure<LogoutResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
