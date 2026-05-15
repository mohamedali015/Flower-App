import '../entities/user_entity.dart';
import '../../../error_handling/result.dart';

abstract interface class UserRepo {
  Future<Result<UserEntity>> getUserData();
}
