import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/api/home_api_client.dart';
import 'package:flower_app/features/home/data/data_source/home_data_source.dart';
import 'package:flower_app/features/home/data/model/home_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final HomeApiClient _apiClient;

  HomeDataSourceImpl(this._apiClient);
  @override
  Future<Result<HomeResponse>> getHome() {
    return executeApi<HomeResponse>(() {
      return _apiClient.getHome();
    });
  }
}
