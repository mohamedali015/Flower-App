import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/data/model/home_response.dart';

abstract interface class HomeDataSource {
  Future<Result<HomeResponse>> getHome();
}
