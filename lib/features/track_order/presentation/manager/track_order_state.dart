import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/driver_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/entities/track_order_entity.dart';

class TrackOrderState extends Equatable {
  final BaseState<TrackOrderEntity> trackOrderState;
  final BaseState<RouteEntity> routeState;
  final BaseState<void> updateOrderState;
  final BaseState<DriverEntity> driverState;

  const TrackOrderState({
    this.trackOrderState = const BaseState(),
    this.routeState = const BaseState(),
    this.updateOrderState = const BaseState(),
    this.driverState = const BaseState(),
  });

  TrackOrderState copyWith({
    BaseState<TrackOrderEntity>? trackOrderStateParam,
    BaseState<RouteEntity>? routeStateParam,
    BaseState<void>? updateOrderStateParam,
    BaseState<DriverEntity>? driverStateParam,
  }) {
    return TrackOrderState(
      trackOrderState: trackOrderStateParam ?? trackOrderState,
      routeState: routeStateParam ?? routeState,
      updateOrderState: updateOrderStateParam ?? updateOrderState,
      driverState: driverStateParam ?? driverState,
    );
  }

  @override
  List<Object?> get props => [
    trackOrderState,
    routeState,
    updateOrderState,
    driverState,
  ];
}
