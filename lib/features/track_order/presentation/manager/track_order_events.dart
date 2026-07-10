sealed class TrackOrderEvents {}

class GetTrackOrderEvent extends TrackOrderEvents {
  final String orderId;

  GetTrackOrderEvent({required this.orderId});
}

class GetRouteEvent extends TrackOrderEvents {
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;

  GetRouteEvent({
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
  });
}

class UpdateOrderToCompletedEvent extends TrackOrderEvents {
  final String orderId;

  UpdateOrderToCompletedEvent({required this.orderId});
}
