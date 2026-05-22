/*
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user/domain/repositories/user_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  LogoutUseCase(this._userRepo);

  final UserRepo _userRepo;

  Future<Result<Map<String, String>>> call() async {
    var response = await _userRepo.logout();
    switch (response) {
      case Success<Map<String, String>>():
        return Success(data: response.data);
      case Failure<Map<String, String>>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
*/
