import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteEntity extends Equatable {
  final List<LatLng> points;

  const RouteEntity({required this.points});

  @override
  List<Object?> get props => [points];
}
