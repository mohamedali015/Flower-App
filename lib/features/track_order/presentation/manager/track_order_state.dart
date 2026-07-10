import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/entities/track_order_entity.dart';

class TrackOrderState extends Equatable {
  final BaseState<TrackOrderEntity> trackOrderState;
  final BaseState<RouteEntity> routeState;

  const TrackOrderState({
    this.trackOrderState = const BaseState(),
    this.routeState = const BaseState(),
  });

  TrackOrderState copyWith({
    BaseState<TrackOrderEntity>? trackOrderStateParam,
    BaseState<RouteEntity>? routeStateParam,
  }) {
    return TrackOrderState(
      trackOrderState: trackOrderStateParam ?? trackOrderState,
      routeState: routeStateParam ?? routeState,
    );
  }

  @override
  List<Object?> get props => [trackOrderState, routeState];
}
