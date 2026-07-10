import '../entities/track_order_entity.dart';

abstract interface class TrackOrderRepo {
  Stream<TrackOrderEntity> watchOrder(String orderId);
}
