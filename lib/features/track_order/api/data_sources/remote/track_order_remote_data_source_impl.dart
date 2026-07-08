import 'package:injectable/injectable.dart';

import '../../../data/data_sources/remote/track_order_remote_data_source.dart';
import '../../track_order_api_client.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  final TrackOrderApiClient _apiClient;

  TrackOrderRemoteDataSourceImpl(this._apiClient);
}
