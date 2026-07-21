import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_cubit/base_event.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/entities/driver_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/route_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_driver_use_case.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_route_use_case.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_track_order_use_case.dart';
import 'package:flower_app/features/track_order/domain/use_cases/update_order_to_completed_use_case.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_cubit.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_cubit_test.mocks.dart';

@GenerateMocks([
  GetTrackOrderUseCase,
  GetDriverUseCase,
  GetRouteUseCase,
  UpdateOrderToCompletedUseCase,
])
void main() {
  late TrackOrderCubit cubit;
  late MockGetTrackOrderUseCase mockGetTrackOrderUseCase;
  late MockGetDriverUseCase mockGetDriverUseCase;
  late MockGetRouteUseCase mockGetRouteUseCase;
  late MockUpdateOrderToCompletedUseCase mockUpdateOrderToCompletedUseCase;

  setUpAll(() {
    provideDummy<Result<RouteEntity>>(
      Success(data: const RouteEntity(points: [])),
    );
    provideDummy<Result<void>>(Success(data: null));
  });

  setUp(() {
    mockGetTrackOrderUseCase = MockGetTrackOrderUseCase();
    mockGetDriverUseCase = MockGetDriverUseCase();
    mockGetRouteUseCase = MockGetRouteUseCase();
    mockUpdateOrderToCompletedUseCase = MockUpdateOrderToCompletedUseCase();

    cubit = TrackOrderCubit(
      mockGetTrackOrderUseCase,
      mockGetRouteUseCase,
      mockUpdateOrderToCompletedUseCase,
      mockGetDriverUseCase,
    );
  });

  group('TrackOrderCubit Test Group', () {
    const tOrderId = '123';
    const tDriverId = '456';
    const tTrackOrderEntity = TrackOrderEntity(
      id: tOrderId,
      orderNumber: 'ORD-1',
      orderStatus: 'pending',
      isActive: true,
      driverId: tDriverId,
      totalPrice: 100,
      paymentType: 'cash',
      isPaid: false,
      isDelivered: false,
      state: '',
      createdAt: '',
      updatedAt: '',
      paidAt: '',
      v: 0,
      user: TrackOrderUserEntity(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        photo: '',
      ),
      store: TrackOrderStoreEntity(
        name: '',
        image: '',
        phoneNumber: '',
        address: '',
        latLong: '',
      ),
      shippingAddress: TrackOrderShippingAddressEntity(
        street: '',
        city: '',
        phone: '',
        lat: '',
        long: '',
      ),
      orderItems: [],
      currentLocation: TrackOrderCurrentLocationEntity(
        latitude: 0,
        longitude: 0,
      ),
    );

    const tDriverEntity = DriverEntity(
      firstName: 'John',
      lastName: 'Doe',
      email: 'j@j.com',
      phone: '123',
    );

    group('GetTrackOrderEvent', () {
      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then success and start watching driver when GetTrackOrderEvent is added',
        setUp: () {
          when(
            mockGetTrackOrderUseCase.call(tOrderId),
          ).thenAnswer((_) => Stream.value(tTrackOrderEntity));
          when(
            mockGetDriverUseCase.call(tDriverId),
          ).thenAnswer((_) => Stream.value(tDriverEntity));
        },
        build: () => cubit,
        act: (cubit) => cubit.doEvent(GetTrackOrderEvent(orderId: tOrderId)),
        expect: () => [
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(isLoadingParam: true),
          ),
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(
                  isLoadingParam: false,
                  isSuccessParam: true,
                  dataParam: tTrackOrderEntity,
                ),
          ),
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(
                  isLoadingParam: false,
                  isSuccessParam: true,
                  dataParam: tTrackOrderEntity,
                ),
            driverStateParam: const TrackOrderState().driverState.copyWith(
              isLoadingParam: true,
            ),
          ),
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(
                  isLoadingParam: false,
                  isSuccessParam: true,
                  dataParam: tTrackOrderEntity,
                ),
            driverStateParam: const TrackOrderState().driverState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: tDriverEntity,
            ),
          ),
        ],
      );

      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then failure when GetTrackOrderEvent fails',
        setUp: () {
          when(
            mockGetTrackOrderUseCase.call(tOrderId),
          ).thenAnswer((_) => Stream.error('Stream error'));
        },
        build: () => cubit,
        act: (cubit) => cubit.doEvent(GetTrackOrderEvent(orderId: tOrderId)),
        expect: () => [
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(isLoadingParam: true),
          ),
          const TrackOrderState().copyWith(
            trackOrderStateParam: const TrackOrderState().trackOrderState
                .copyWith(
                  isLoadingParam: false,
                  errorMessageParam: 'Stream error',
                ),
          ),
        ],
      );
    });

    group('GetRouteEvent', () {
      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then success when GetRouteEvent is successful',
        setUp: () {
          when(
            mockGetRouteUseCase.call(
              startLat: anyNamed('startLat'),
              startLng: anyNamed('startLng'),
              endLat: anyNamed('endLat'),
              endLng: anyNamed('endLng'),
            ),
          ).thenAnswer(
            (_) async => Success(data: const RouteEntity(points: [])),
          );
        },
        build: () => cubit,
        act: (cubit) => cubit.doEvent(
          GetRouteEvent(startLat: 0, startLng: 0, endLat: 1, endLng: 1),
        ),
        expect: () => [
          const TrackOrderState().copyWith(
            routeStateParam: const TrackOrderState().routeState.copyWith(
              isLoadingParam: true,
            ),
          ),
          const TrackOrderState().copyWith(
            routeStateParam: const TrackOrderState().routeState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: const RouteEntity(points: []),
            ),
          ),
        ],
      );

      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then failure when GetRouteEvent fails',
        setUp: () {
          when(
            mockGetRouteUseCase.call(
              startLat: anyNamed('startLat'),
              startLng: anyNamed('startLng'),
              endLat: anyNamed('endLat'),
              endLng: anyNamed('endLng'),
            ),
          ).thenAnswer((_) async => Failure(errorMessage: 'Route error'));
        },
        build: () => cubit,
        act: (cubit) => cubit.doEvent(
          GetRouteEvent(startLat: 0, startLng: 0, endLat: 1, endLng: 1),
        ),
        expect: () => [
          const TrackOrderState().copyWith(
            routeStateParam: const TrackOrderState().routeState.copyWith(
              isLoadingParam: true,
            ),
          ),
          const TrackOrderState().copyWith(
            routeStateParam: const TrackOrderState().routeState.copyWith(
              isLoadingParam: false,
              errorMessageParam: 'Route error',
            ),
          ),
        ],
      );
    });

    group('UpdateOrderToCompletedEvent', () {
      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then success and navigation event when UpdateOrderToCompletedEvent is successful',
        setUp: () {
          when(
            mockUpdateOrderToCompletedUseCase.call(tOrderId),
          ).thenAnswer((_) async => Success(data: null));
        },
        build: () => cubit,
        act: (cubit) =>
            cubit.doEvent(UpdateOrderToCompletedEvent(orderId: tOrderId)),
        expect: () => [
          const TrackOrderState().copyWith(
            updateOrderStateParam: const TrackOrderState().updateOrderState
                .copyWith(isLoadingParam: true),
          ),
          const TrackOrderState().copyWith(
            updateOrderStateParam: const TrackOrderState().updateOrderState
                .copyWith(isLoadingParam: false, isSuccessParam: true),
          ),
        ],
        verify: (cubit) {
          // Check if NavigationEvent was emitted to eventStream
          expect(cubit.eventStream, emits(isA<NavigationEvent>()));
        },
      );

      blocTest<TrackOrderCubit, TrackOrderState>(
        'should emit loading then failure when UpdateOrderToCompletedEvent fails',
        setUp: () {
          when(
            mockUpdateOrderToCompletedUseCase.call(tOrderId),
          ).thenAnswer((_) async => Failure(errorMessage: 'Update error'));
        },
        build: () => cubit,
        act: (cubit) =>
            cubit.doEvent(UpdateOrderToCompletedEvent(orderId: tOrderId)),
        expect: () => [
          const TrackOrderState().copyWith(
            updateOrderStateParam: const TrackOrderState().updateOrderState
                .copyWith(isLoadingParam: true),
          ),
          const TrackOrderState().copyWith(
            updateOrderStateParam: const TrackOrderState().updateOrderState
                .copyWith(
                  isLoadingParam: false,
                  errorMessageParam: 'Update error',
                ),
          ),
        ],
      );
    });
  });
}
