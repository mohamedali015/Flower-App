import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/values/api_end_points.dart';
import '../../domain/entities/track_order_entity.dart';
import '../manager/track_order_cubit.dart';
import '../manager/track_order_events.dart';
import '../manager/track_order_state.dart';

class LiveMapWidget extends StatefulWidget {
  final TrackOrderEntity order;

  const LiveMapWidget({super.key, required this.order});

  @override
  State<LiveMapWidget> createState() => _LiveMapWidgetState();
}

class _LiveMapWidgetState extends State<LiveMapWidget> {
  final MapController _mapController = MapController();
  late LatLng _storeLocation;
  LatLng? _userCurrentLocation;
  late ValueNotifier<LatLng> _driverLocationNotifier;
  bool _initialBoundsSet = false;
  bool _routeFetched = false;

  @override
  void initState() {
    super.initState();
    _storeLocation = _parseLatLong(widget.order.store.latLong);
    _driverLocationNotifier = ValueNotifier(
      LatLng(
        widget.order.currentLocation.latitude.toDouble(),
        widget.order.currentLocation.longitude.toDouble(),
      ),
    );

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    // Step 1: Request permission using permission_handler
    final status = await Permission.location.request();

    if (!status.isGranted) {
      debugPrint('Location permission denied via permission_handler');
      // If denied, we can't do anything for current location
      return;
    }

    int retries = 0;
    while (retries < 5) {
      // Increased retries for better chance
      try {
        Position position = await _determinePosition();
        debugPrint(
          'GPS Location Attempt ${retries + 1}: ${position.latitude}, ${position.longitude}',
        );

        if (position.latitude != 0 && position.longitude != 0) {
          if (mounted) {
            setState(() {
              _userCurrentLocation = LatLng(
                position.latitude,
                position.longitude,
              );
            });
            _fetchInitialRoute();
            _fitBounds();
          }
          return;
        }
      } catch (e) {
        debugPrint('Error getting location attempt ${retries + 1}: $e');
      }
      retries++;
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Wait longer between retries
    }
  }

  void _fetchInitialRoute() {
    if (_userCurrentLocation != null && !_routeFetched) {
      context.read<TrackOrderCubit>().doEvent(
        GetRouteEvent(
          startLat: _driverLocationNotifier.value.latitude,
          startLng: _driverLocationNotifier.value.longitude,
          endLat: _userCurrentLocation!.latitude,
          endLng: _userCurrentLocation!.longitude,
        ),
      );
      _routeFetched = true;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Permission is already checked in _getUserLocation
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  @override
  void dispose() {
    _driverLocationNotifier.dispose();
    _mapController.dispose();
    super.dispose();
  }

  LatLng _parseLatLong(String latLong) {
    try {
      final parts = latLong.split(',');
      if (parts.length >= 2) {
        return LatLng(double.parse(parts[0]), double.parse(parts[1]));
      }
    } catch (e) {
      debugPrint('Error parsing latLong: $e');
    }
    return const LatLng(0, 0);
  }

  void _fitBounds() {
    if (!_initialBoundsSet) {
      final List<LatLng> points = [];

      if (_storeLocation.latitude != 0) points.add(_storeLocation);
      if (_driverLocationNotifier.value.latitude != 0) {
        points.add(_driverLocationNotifier.value);
      }
      if (_userCurrentLocation != null && _userCurrentLocation!.latitude != 0) {
        points.add(_userCurrentLocation!);
      }

      if (points.length >= 2) {
        final bounds = LatLngBounds.fromPoints(points);
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(120),
            maxZoom: 13.0,
          ),
        );
        // Only mark as set if we have all 3 or at least 2 and user is handled
        if (points.length == 3 || _userCurrentLocation != null) {
          _initialBoundsSet = true;
        }
      }
    }
  }

  void _moveToMyLocation() {
    if (_userCurrentLocation != null) {
      _mapController.move(_userCurrentLocation!, 13.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocListener<TrackOrderCubit, TrackOrderState>(
      listenWhen: (prev, current) =>
          prev.trackOrderState.data?.currentLocation !=
          current.trackOrderState.data?.currentLocation,
      listener: (context, state) {
        final order = state.trackOrderState.data;
        if (order != null) {
          final newLoc = LatLng(
            order.currentLocation.latitude.toDouble(),
            order.currentLocation.longitude.toDouble(),
          );
          _driverLocationNotifier.value = newLoc;

          // Re-fetch route from NEW driver location to user location
          if (_userCurrentLocation != null) {
            context.read<TrackOrderCubit>().doEvent(
              GetRouteEvent(
                startLat: newLoc.latitude,
                startLng: newLoc.longitude,
                endLat: _userCurrentLocation!.latitude,
                endLng: _userCurrentLocation!.longitude,
              ),
            );
          }
          _fitBounds();
        }
      },
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _driverLocationNotifier.value.latitude != 0
                  ? _driverLocationNotifier.value
                  : _storeLocation.latitude != 0
                  ? _storeLocation
                  : const LatLng(30.0444, 31.2357),
              initialZoom: 14,
              onMapReady: _fitBounds,
            ),
            children: [
              TileLayer(
                urlTemplate: ApiEndPoints.openStreetMapTiles,
                userAgentPackageName: AppConstants.appPackageName,
              ),
              // Route Layer
              BlocBuilder<TrackOrderCubit, TrackOrderState>(
                buildWhen: (prev, current) =>
                    prev.routeState != current.routeState,
                builder: (context, state) {
                  if (state.routeState.data != null) {
                    return PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.routeState.data!.points,
                          color: AppColors.primaryColor,
                          strokeWidth: 4,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // Static Markers (Store & User)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _storeLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.store,
                      color: AppColors.black100,
                      size: 40,
                    ),
                  ),
                  if (_userCurrentLocation != null)
                    Marker(
                      point: _userCurrentLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: AppColors.success,
                        size: 40,
                      ),
                    ),
                ],
              ),
              // Dynamic Driver Marker
              ValueListenableBuilder<LatLng>(
                valueListenable: _driverLocationNotifier,
                builder: (context, driverLoc, _) {
                  return MarkerLayer(
                    markers: [
                      Marker(
                        point: driverLoc,
                        width: 50,
                        height: 50,
                        child: const SvgWrapper(
                          path: AppAssets.deliveryMotorcycleIcon,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          // My Location Button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: _moveToMyLocation,
              tooltip: local.myLocation,
              child: const Icon(
                Icons.my_location,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
