import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeUseCase {
  final HomeRepo _homeRepo;

  GetHomeUseCase(this._homeRepo);

  Future<Result<HomeResponseEntity>> call() {
    return _homeRepo.getHome();
  }
}
