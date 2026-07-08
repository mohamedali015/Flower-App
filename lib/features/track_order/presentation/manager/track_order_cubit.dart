import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/get_track_order_use_case.dart';
import 'track_order_events.dart';
import 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetTrackOrderUseCase _getTrackOrderUseCase;

  TrackOrderCubit(this._getTrackOrderUseCase) : super(const TrackOrderState());

  void doEvent(TrackOrderEvents event) {
    switch (event) {
      case GetTrackOrderEvent():
        _getTrackOrder(event);
    }
  }

  Future<void> _getTrackOrder(GetTrackOrderEvent event) async {
    // TODO: Implement track order logic
  }
}
