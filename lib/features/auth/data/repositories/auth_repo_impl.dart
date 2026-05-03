import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_source/remote/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

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
    // TODO: implement register
    throw UnimplementedError();
  }
}
