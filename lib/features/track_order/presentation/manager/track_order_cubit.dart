import 'dart:async';

import 'package:flower_app/config/base_cubit/base_cubit.dart';
import 'package:flower_app/config/base_cubit/base_event.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/use_cases/get_driver_use_case.dart';
import '../../domain/use_cases/get_route_use_case.dart';
import '../../domain/use_cases/get_track_order_use_case.dart';
import '../../domain/use_cases/update_order_to_completed_use_case.dart';
import 'track_order_events.dart';
import 'track_order_state.dart';

@injectable
class TrackOrderCubit extends BaseCubit<TrackOrderState, BaseEvent> {
  final GetTrackOrderUseCase _getTrackOrderUseCase;
  final GetRouteUseCase _getRouteUseCase;
  final UpdateOrderToCompletedUseCase _updateOrderToCompletedUseCase;
  final GetDriverUseCase _getDriverUseCase;
  StreamSubscription? _orderSubscription;
  StreamSubscription? _driverSubscription;
  String? _currentDriverId;

  TrackOrderCubit(
    this._getTrackOrderUseCase,
    this._getRouteUseCase,
    this._updateOrderToCompletedUseCase,
    this._getDriverUseCase,
  ) : super(const TrackOrderState());

  void doEvent(TrackOrderEvents event) {
    switch (event) {
      case GetTrackOrderEvent():
        _watchTrackOrder(event.orderId);
      case GetRouteEvent():
        _getRoute(event);
      case UpdateOrderToCompletedEvent():
        _updateOrderToCompleted(event.orderId);
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

            if (order.driverId.isNotEmpty &&
                order.driverId != _currentDriverId) {
              _watchDriver(order.driverId);
            }
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

  void _watchDriver(String driverId) {
    _currentDriverId = driverId;
    _driverSubscription?.cancel();

    emit(
      state.copyWith(
        driverStateParam: state.driverState.copyWith(isLoadingParam: true),
      ),
    );

    _driverSubscription = _getDriverUseCase
        .call(driverId)
        .listen(
          (driver) {
            emit(
              state.copyWith(
                driverStateParam: state.driverState.copyWith(
                  isLoadingParam: false,
                  isSuccessParam: true,
                  dataParam: driver,
                ),
              ),
            );
          },
          onError: (error) {
            emit(
              state.copyWith(
                driverStateParam: state.driverState.copyWith(
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

  Future<void> _updateOrderToCompleted(String orderId) async {
    emit(
      state.copyWith(
        updateOrderStateParam: state.updateOrderState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final result = await _updateOrderToCompletedUseCase.call(orderId);

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            updateOrderStateParam: state.updateOrderState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
            ),
          ),
        );
        emitEvent(
          const NavigationEvent(
            routeName: Routes.ordersRoute,
            type: NavigationType.pop,
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            updateOrderStateParam: state.updateOrderState.copyWith(
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
    _driverSubscription?.cancel();
    return super.close();
  }
}
