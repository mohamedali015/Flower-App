import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/values/api_end_points.dart';

class AppMap extends StatelessWidget {
  final MapController controller;
  final List<Widget> layers;
  final VoidCallback? onMapReady;
  final LatLng initialCenter;
  final double initialZoom;

  const AppMap({
    super.key,
    required this.controller,
    required this.layers,
    this.onMapReady,
    required this.initialCenter,
    this.initialZoom = 14,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        onMapReady: onMapReady,
      ),
      children: [
        TileLayer(
          urlTemplate: ApiEndPoints.openStreetMapTiles,
          userAgentPackageName: AppConstants.appPackageName,
        ),
        ...layers,
      ],
    );
  }
}
