import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';
import '../models/remote/open_route_response.dart';

extension OpenRouteResponseMapper on OpenRouteResponse? {
  RouteEntity toEntity() {
    final List<LatLng> points = [];
    if (this?.features != null && this!.features!.isNotEmpty) {
      final coordinates = this!.features!.first.geometry?.coordinates;
      if (coordinates != null) {
        for (var cord in coordinates) {
          if (cord.length >= 2) {
            // OpenRouteService returns [longitude, latitude]
            points.add(LatLng(cord[1], cord[0]));
          }
        }
      }
    }
    return RouteEntity(points: points);
  }
}
