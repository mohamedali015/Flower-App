import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_error_widget.dart';
import '../../../../core/shared_widgets/custom_loading_indicator.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/track_order_entity.dart';
import '../manager/track_order_cubit.dart';
import '../manager/track_order_events.dart';
import '../manager/track_order_state.dart';
import 'app_map.dart';

class LiveMapWidget extends StatefulWidget {
  final TrackOrderEntity order;

  const LiveMapWidget({super.key, required this.order});

  @override
  State<LiveMapWidget> createState() => _LiveMapWidgetState();
}

class _LiveMapWidgetState extends State<LiveMapWidget> {
  static const String _myLocationHeroTag = 'my_location_btn';
  static const String _zoomInHeroTag = 'zoom_in_btn';
  static const String _zoomOutHeroTag = 'zoom_out_btn';
  static const String _latLongSeparator = ',';
  static const String _errorGettingLocationMsg =
      'Error getting location attempt';
  static const String _errorParsingLatLongMsg = 'Error parsing latLong:';

  static const double _initialZoom = 14.0;
  static const double _maxZoom = 14.0;
  static const double _myLocationZoom = 14.0;
  static const double _fitBoundsPadding = 120.0;

  final MapController _mapController = MapController();
  late LatLng _storeLocation;
  LatLng? _userCurrentLocation;
  late ValueNotifier<LatLng> _driverLocationNotifier;
  bool _initialBoundsSet = false;
  bool _routeFetched = false;
  bool _isPermissionDenied = false;
  bool _isLoadingLocation = true;

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
    setState(() {
      _isLoadingLocation = true;
      _isPermissionDenied = false;
    });

    final status = await Permission.location.request();

    if (!status.isGranted) {
      if (mounted) {
        setState(() {
          _isPermissionDenied = true;
          _isLoadingLocation = false;
        });
      }
      return;
    }

    int retries = 0;
    while (retries < 5) {
      if (!mounted) return;
      try {
        final local = AppLocalizations.of(context)!;
        Position position = await _determinePosition(
          local.locationServicesDisabled,
        );
        if (position.latitude != 0 && position.longitude != 0) {
          if (mounted) {
            setState(() {
              _userCurrentLocation = LatLng(
                position.latitude,
                position.longitude,
              );
              _isLoadingLocation = false;
            });
            _fetchInitialRoute();
            _fitBounds();
          }
          return;
        }
      } catch (e) {
        debugPrint('$_errorGettingLocationMsg ${retries + 1}: $e');
      }
      retries++;
      await Future.delayed(const Duration(seconds: 2));
    }

    if (mounted) {
      setState(() {
        _isLoadingLocation = false;
        // If still null, we could potentially show an error or a default location,
        // but user asked not to render map before getting location.
      });
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

  Future<Position> _determinePosition(String errorMessage) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(errorMessage);
    }

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
      final parts = latLong.split(_latLongSeparator);
      if (parts.length >= 2) {
        return LatLng(double.parse(parts[0]), double.parse(parts[1]));
      }
    } catch (e) {
      debugPrint('$_errorParsingLatLongMsg $e');
    }
    return const LatLng(0, 0);
  }

  void _fitBounds() {
    if (!_initialBoundsSet && _userCurrentLocation != null) {
      final List<LatLng> points = [];

      if (_storeLocation.latitude != 0) points.add(_storeLocation);
      if (_driverLocationNotifier.value.latitude != 0) {
        points.add(_driverLocationNotifier.value);
      }
      if (_userCurrentLocation!.latitude != 0) {
        points.add(_userCurrentLocation!);
      }

      if (points.length >= 2) {
        final bounds = LatLngBounds.fromPoints(points);
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(_fitBoundsPadding),
            maxZoom: _maxZoom,
          ),
        );
        if (points.length == 3) {
          _initialBoundsSet = true;
        }
      }
    }
  }

  void _moveToMyLocation() {
    if (_userCurrentLocation != null) {
      _mapController.move(_userCurrentLocation!, _myLocationZoom);
    }
  }

  void _zoomIn() {
    _mapController.move(
      _mapController.camera.center,
      _mapController.camera.zoom + 1,
    );
  }

  void _zoomOut() {
    _mapController.move(
      _mapController.camera.center,
      _mapController.camera.zoom - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isPermissionDenied) {
      return CustomErrorWidget(
        errorMessage: local.locationPermissionDenied,
        haveTryAgain: true,
        onPressed: _getUserLocation,
      );
    }

    if (_isLoadingLocation || _userCurrentLocation == null) {
      return const Center(child: CustomLoadingIndicator());
    }

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
          // Only re-fit bounds if we haven't successfully fit all 3 markers yet
          if (!_initialBoundsSet) {
            _fitBounds();
          }
        }
      },
      child: Stack(
        children: [
          AppMap(
            controller: _mapController,
            initialCenter: _driverLocationNotifier.value,
            initialZoom: _initialZoom,
            onMapReady: _fitBounds,
            layers: [
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
              heroTag: _myLocationHeroTag,
              child: const Icon(
                Icons.my_location,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          // Zoom Buttons
          Positioned(
            right: 16,
            bottom: 76,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: AppColors.white,
                  onPressed: _zoomIn,
                  heroTag: _zoomInHeroTag,
                  child: const Icon(Icons.add, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: AppColors.white,
                  onPressed: _zoomOut,
                  heroTag: _zoomOutHeroTag,
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
