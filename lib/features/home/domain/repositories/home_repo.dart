import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

abstract interface class HomeRepo {
  Future<Result<HomeResponseEntity>> getHome();
}
