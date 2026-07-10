import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/track_order_entity.dart';

class TrackOrderState extends Equatable {
  final BaseState<TrackOrderEntity> trackOrderState;

  const TrackOrderState({this.trackOrderState = const BaseState()});

  TrackOrderState copyWith({
    BaseState<TrackOrderEntity>? trackOrderStateParam,
  }) {
    return TrackOrderState(
      trackOrderState: trackOrderStateParam ?? trackOrderState,
    );
  }

  @override
  List<Object?> get props => [trackOrderState];
}
