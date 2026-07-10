import '../../models/response/track_order_response.dart';

abstract interface class TrackOrderRemoteDataSource {
  Stream<TrackOrderResponse?> watchOrder(String orderId);
}
