import '../../../../config/error_handling/result.dart';
import '../entities/route_entity.dart';
import '../entities/track_order_entity.dart';

abstract interface class TrackOrderRepo {
  Stream<TrackOrderEntity> watchOrder(String orderId);

  Future<Result<RouteEntity>> getRoute({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  });

  Future<Result<void>> updateOrderToCompleted(String orderId);
}
