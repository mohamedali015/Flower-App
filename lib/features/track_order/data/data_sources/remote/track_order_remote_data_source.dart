import '../../../../../config/error_handling/result.dart';
import '../../models/remote/open_route_response.dart';
import '../../models/response/track_order_response.dart';

abstract interface class TrackOrderRemoteDataSource {
  Stream<TrackOrderResponse?> watchOrder(String orderId);

  Future<Result<OpenRouteResponse>> getRoute({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  });

  Future<Result<void>> updateOrderToCompleted(String orderId);
}
