import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/orders/domain/entities/orders_grouped_entity.dart';

class OrdersState extends Equatable {
  final BaseState<OrdersGroupedEntity> ordersState;
  final bool isFetchingMore;

  const OrdersState({
    this.ordersState = const BaseState(),
    this.isFetchingMore = false,
  });

  OrdersState copyWith({
    BaseState<OrdersGroupedEntity>? ordersStateParam,
    bool? isFetchingMoreParam,
  }) {
    return OrdersState(
      ordersState: ordersStateParam ?? ordersState,
      isFetchingMore: isFetchingMoreParam ?? isFetchingMore,
    );
  }

  @override
  List<Object?> get props => [ordersState, isFetchingMore];
}
