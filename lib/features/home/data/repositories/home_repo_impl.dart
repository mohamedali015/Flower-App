import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/data/data_source/home_data_source.dart';
import 'package:flower_app/features/home/data/mappers/home_response_mapper.dart';
import 'package:flower_app/features/home/data/model/home_response.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeDataSource _homeDataSource;

  HomeRepoImpl(this._homeDataSource);

  @override
  Future<Result<HomeResponseEntity>> getHome() async {
    final response = await _homeDataSource.getHome();

    switch (response) {
      case Success<HomeResponse>():
        return Success<HomeResponseEntity>(data: response.data.toEntity());
      case Failure<HomeResponse>():
        return Failure<HomeResponseEntity>(errorMessage: response.errorMessage);
    }
  }
}
