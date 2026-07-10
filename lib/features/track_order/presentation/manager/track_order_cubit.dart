import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_track_order_use_case.dart';
import 'track_order_events.dart';
import 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetTrackOrderUseCase _getTrackOrderUseCase;
  StreamSubscription? _orderSubscription;

  TrackOrderCubit(this._getTrackOrderUseCase) : super(const TrackOrderState());

  void doEvent(TrackOrderEvents event) {
    switch (event) {
      case GetTrackOrderEvent():
        _watchTrackOrder(event.orderId);
    }
  }

  void _watchTrackOrder(String orderId) {
    emit(
      state.copyWith(
        trackOrderStateParam: state.trackOrderState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    _orderSubscription?.cancel();
    _orderSubscription = _getTrackOrderUseCase
        .call(orderId)
        .listen(
          (order) {
            emit(
              state.copyWith(
                trackOrderStateParam: state.trackOrderState.copyWith(
                  isLoadingParam: false,
                  isSuccessParam: true,
                  dataParam: order,
                ),
              ),
            );
          },
          onError: (error) {
            emit(
              state.copyWith(
                trackOrderStateParam: state.trackOrderState.copyWith(
                  isLoadingParam: false,
                  errorMessageParam: error.toString(),
                ),
              ),
            );
          },
        );
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
