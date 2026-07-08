import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';

class TrackOrderState extends Equatable {
  final BaseState<dynamic> trackOrderState;

  const TrackOrderState({this.trackOrderState = const BaseState()});

  TrackOrderState copyWith({BaseState<dynamic>? trackOrderStateParam}) {
    return TrackOrderState(
      trackOrderState: trackOrderStateParam ?? trackOrderState,
    );
  }

  @override
  List<Object?> get props => [trackOrderState];
}
