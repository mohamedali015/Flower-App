import 'package:flower_app/config/data_base/data_base_service.dart';
import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/firebase/firestore_collection.dart';
import 'package:flower_app/features/track_order/api/open_route_api_client.dart';
import 'package:flower_app/features/track_order/data/data_sources/remote/track_order_remote_data_source.dart';
import 'package:flower_app/features/track_order/data/models/remote/open_route_response.dart';
import 'package:flower_app/features/track_order/data/models/response/track_order_response.dart';
import 'package:flower_app/secret_keys.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  final DatabaseService _databaseService;
  final OpenRouteApiClient _openRouteApiClient;

  TrackOrderRemoteDataSourceImpl(
    this._databaseService,
    this._openRouteApiClient,
  );

  @override
  Stream<TrackOrderResponse?> watchOrder(String orderId) {
    return _databaseService.watchDocument<TrackOrderResponse>(
      path: "${FireStoreCollection.orderCollectionPath}/$orderId",
      fromFirestore: (json) => TrackOrderResponse.fromJson(json),
    );
  }

  @override
  Future<Result<OpenRouteResponse>> getRoute({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return executeApi<OpenRouteResponse>(() {
      return _openRouteApiClient.getRoute(
        apiKey: SecretKeys.openRouteServiceKey,
        start: "$startLng,$startLat",
        end: "$endLng,$endLat",
      );
    });
  }
}
