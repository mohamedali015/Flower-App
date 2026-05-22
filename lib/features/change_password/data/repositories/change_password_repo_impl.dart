import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/change_password/data/data_source/change_password_data_source.dart';
import 'package:flower_app/features/change_password/data/models/change_password_response.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flower_app/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final SecureCache secureCache;

  final ChangePasswordDataSource _dataSource;

  ChangePasswordRepoImpl(this.secureCache, this._dataSource);

  @override
  Future<Result<ChangePasswordResponseEntity>> changePassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  }) async {
    final response = await _dataSource.changePassword(
      changePasswordRequest: changePasswordRequestEntity.toModel(),
    );

    switch (response) {
      case Success<ChangePasswordResponse>():
        final entity = response.data.toEntity();
        if (entity.token != null && entity.token!.isNotEmpty) {
          await secureCache.saveData(
            key: CacheKeys.token,
            value: response.data.token!,
          );
        }
        return Success(data: entity);
      case Failure<ChangePasswordResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
