import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/use_cases/get_route_use_case.dart';
import '../../domain/use_cases/get_track_order_use_case.dart';
import 'track_order_events.dart';
import 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final GetTrackOrderUseCase _getTrackOrderUseCase;
  final GetRouteUseCase _getRouteUseCase;
  StreamSubscription? _orderSubscription;

  TrackOrderCubit(this._getTrackOrderUseCase, this._getRouteUseCase)
    : super(const TrackOrderState());

  void doEvent(TrackOrderEvents event) {
    switch (event) {
      case GetTrackOrderEvent():
        _watchTrackOrder(event.orderId);
      case GetRouteEvent():
        _getRoute(event);
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

  Future<void> _getRoute(GetRouteEvent event) async {
    emit(
      state.copyWith(
        routeStateParam: state.routeState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _getRouteUseCase.call(
      startLat: event.startLat,
      startLng: event.startLng,
      endLat: event.endLat,
      endLng: event.endLng,
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            routeStateParam: state.routeState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            routeStateParam: state.routeState.copyWith(
              isLoadingParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
