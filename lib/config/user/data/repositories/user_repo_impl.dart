import 'package:flower_app/features/auth/data/mapper/user_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../../../features/auth/domain/entities/user_entity.dart';
import '../../../error_handling/result.dart';
import '../../domain/repositories/user_repo.dart';
import '../data_sources/remote/user_remote_data_source.dart';
import '../models/responses/get_user_response/get_user_data_response.dart';

@Injectable(as: UserRepo)
class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepoImpl(this._userRemoteDataSource);

  @override
  Future<Result<UserEntity>> getUserData() async {
    final response = await _userRemoteDataSource.getUserData();

    switch (response) {
      case Success<GetUserDataResponse>():
        {
          return Success(data: response.data.user!.toEntity());
        }
      case Failure<GetUserDataResponse>():
        {
          return Failure(errorMessage: response.errorMessage);
        }
    }
  }
}
