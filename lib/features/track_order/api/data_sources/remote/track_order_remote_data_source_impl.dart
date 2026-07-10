import 'package:injectable/injectable.dart';

import '../../../../../config/data_base/data_base_service.dart';
import '../../../../../config/firebase/firestore_collection.dart';
import '../../../data/data_sources/remote/track_order_remote_data_source.dart';
import '../../../data/models/response/track_order_response.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  final DatabaseService _databaseService;

  TrackOrderRemoteDataSourceImpl(this._databaseService);

  @override
  Stream<TrackOrderResponse?> watchOrder(String orderId) {
    return _databaseService.watchDocument<TrackOrderResponse>(
      path: "${FireStoreCollection.orderCollectionPath}/$orderId",
      fromFirestore: (json) => TrackOrderResponse.fromJson(json),
    );
  }
}
