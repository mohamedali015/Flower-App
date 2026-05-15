import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/api/occasions_api_client.dart';
import 'package:flower_app/features/occasions/data/data_source/remote/occasions_remote_data_source.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsRemoteDataSource)
class OccasionsRemoteDataSourceImpl implements OccasionsRemoteDataSource {
  final OccasionsApiClient _apiClient;

  OccasionsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<OccasionsResponse>> getOccasions() {
    return executeApi<OccasionsResponse>(() {
      return _apiClient.getOccasions();
    });
  }
}
