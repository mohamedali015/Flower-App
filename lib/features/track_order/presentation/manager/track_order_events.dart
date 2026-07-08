sealed class TrackOrderEvents {}

class GetTrackOrderEvent extends TrackOrderEvents {
  final String orderId;

  GetTrackOrderEvent({required this.orderId});
}
