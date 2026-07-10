import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flower_app/features/orders/domain/entities/orders_grouped_entity.dart';
import 'package:flower_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_events.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._getOrdersUseCase) : super(const OrdersState());

  final GetOrdersUseCase _getOrdersUseCase;
  int _currentPage = 1;

  void doEvent(OrdersEvents event) {
    switch (event) {
      case GetOrdersEvent():
        _currentPage = 1;
        _getOrders();

      case LoadMoreOrdersEvent():
        _loadMoreOrders();
    }
  }

  Future<void> _getOrders() async {
    emit(
      state.copyWith(
        ordersStateParam: state.ordersState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _getOrdersUseCase.call(
      params: OrdersQueryParams(page: _currentPage, limit: 10),
    );

    switch (result) {
      case Success():
        _currentPage = result.data.metadata.currentPage.toInt();
        emit(
          state.copyWith(
            ordersStateParam: state.ordersState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            ordersStateParam: state.ordersState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _loadMoreOrders() async {
    if (state.isFetchingMore) return;

    final currentData = state.ordersState.data;
    if (currentData == null) return;

    final currentPage = currentData.metadata.currentPage.toInt();
    final totalPages = currentData.metadata.totalPages.toInt();

    if (currentPage >= totalPages) return;

    emit(state.copyWith(isFetchingMoreParam: true));

    final result = await _getOrdersUseCase.call(
      params: OrdersQueryParams(page: currentPage + 1, limit: 10),
    );

    switch (result) {
      case Success():
        final newOrders = result.data;
        final updatedData = OrdersGroupedEntity(
          active: [...currentData.active, ...newOrders.active],
          delivered: [...currentData.delivered, ...newOrders.delivered],
          metadata: newOrders.metadata,
        );

        emit(
          state.copyWith(
            isFetchingMoreParam: false,
            ordersStateParam: state.ordersState.copyWith(
              dataParam: updatedData,
            ),
          ),
        );

      case Failure():
        emit(state.copyWith(isFetchingMoreParam: false));
    }
  }
}
