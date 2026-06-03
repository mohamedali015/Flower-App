import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_grouped_entity.dart';
import 'package:flower_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_events.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([GetOrdersUseCase])
void main() {
  late MockGetOrdersUseCase mockGetOrdersUseCase;
  late OrdersCubit ordersCubit;

  const metadataPage1 = MetadataEntity(
    currentPage: 1,
    totalPages: 2,
    limit: 10,
    totalItems: 20,
  );

  const metadataPage2 = MetadataEntity(
    currentPage: 2,
    totalPages: 2,
    limit: 10,
    totalItems: 20,
  );

  final page1Orders = [OrdersEntity(id: '1', isDelivered: false)];
  final page2Orders = [OrdersEntity(id: '2', isDelivered: true)];

  final groupedPage1 = OrdersGroupedEntity(
    active: page1Orders,
    delivered: const [],
    metadata: metadataPage1,
  );

  final groupedPage2 = OrdersGroupedEntity(
    active: const [],
    delivered: page2Orders,
    metadata: metadataPage2,
  );

  /// ✅ FIX: Mockito dummy value
  setUpAll(() {
    provideDummy<Result<OrdersGroupedEntity>>(
      Failure<OrdersGroupedEntity>(errorMessage: ''),
    );
  });

  setUp(() {
    mockGetOrdersUseCase = MockGetOrdersUseCase();
    ordersCubit = OrdersCubit(mockGetOrdersUseCase);
  });

  test('initial state is OrdersState', () {
    expect(ordersCubit.state, const OrdersState());
  });

  blocTest<OrdersCubit, OrdersState>(
    'emits loading then success when get orders succeeds',
    setUp: () {
      when(
        mockGetOrdersUseCase.call(params: anyNamed('params')),
      ).thenAnswer((_) async => Success(data: groupedPage1));
    },
    build: () => ordersCubit,
    act: (cubit) => cubit.doEvent(GetOrdersEvent()),
    expect: () => [
      const OrdersState().copyWith(
        ordersStateParam: const BaseState<OrdersGroupedEntity>(isLoading: true),
      ),
      const OrdersState().copyWith(
        ordersStateParam: BaseState<OrdersGroupedEntity>(
          isLoading: false,
          isSuccess: true,
          data: groupedPage1,
        ),
      ),
    ],
    verify: (_) {
      verify(mockGetOrdersUseCase.call(params: anyNamed('params'))).called(1);
    },
  );

  blocTest<OrdersCubit, OrdersState>(
    'emits loading then failure when get orders fails',
    setUp: () {
      when(mockGetOrdersUseCase.call(params: anyNamed('params'))).thenAnswer(
        (_) async => Failure<OrdersGroupedEntity>(errorMessage: 'error'),
      );
    },
    build: () => ordersCubit,
    act: (cubit) => cubit.doEvent(GetOrdersEvent()),
    expect: () => [
      const OrdersState().copyWith(
        ordersStateParam: const BaseState<OrdersGroupedEntity>(isLoading: true),
      ),
      const OrdersState().copyWith(
        ordersStateParam: const BaseState<OrdersGroupedEntity>(
          isLoading: false,
          isSuccess: false,
          errorMessage: 'error',
        ),
      ),
    ],
    verify: (_) {
      verify(mockGetOrdersUseCase.call(params: anyNamed('params'))).called(1);
    },
  );

  blocTest<OrdersCubit, OrdersState>(
    'emits fetching more then appends orders on load more',
    setUp: () {
      when(
        mockGetOrdersUseCase.call(params: anyNamed('params')),
      ).thenAnswer((_) async => Success(data: groupedPage2));
    },
    build: () => ordersCubit,
    seed: () => OrdersState(
      ordersState: BaseState<OrdersGroupedEntity>(data: groupedPage1),
    ),
    act: (cubit) => cubit.doEvent(LoadMoreOrdersEvent()),
    expect: () => [
      OrdersState(
        ordersState: BaseState<OrdersGroupedEntity>(data: groupedPage1),
        isFetchingMore: true,
      ),
      OrdersState(
        ordersState: BaseState<OrdersGroupedEntity>(
          data: OrdersGroupedEntity(
            active: page1Orders,
            delivered: page2Orders,
            metadata: metadataPage2,
          ),
        ),
        isFetchingMore: false,
      ),
    ],
    verify: (_) {
      verify(mockGetOrdersUseCase.call(params: anyNamed('params'))).called(1);
    },
  );
}
