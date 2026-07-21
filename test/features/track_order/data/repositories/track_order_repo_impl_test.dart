import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_sources/remote/track_order_remote_data_source.dart';
import 'package:flower_app/features/track_order/data/models/remote/open_route_response.dart';
import 'package:flower_app/features/track_order/data/models/response/driver_model.dart';
import 'package:flower_app/features/track_order/data/models/response/track_order_response.dart';
import 'package:flower_app/features/track_order/data/repositories/track_order_repo_impl.dart';
import 'package:flower_app/features/track_order/domain/entities/driver_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/route_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_repo_impl_test.mocks.dart';

@GenerateMocks([TrackOrderRemoteDataSource])
void main() {
  late TrackOrderRepoImpl repository;
  late MockTrackOrderRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<OpenRouteResponse>>(Success(data: OpenRouteResponse()));
    provideDummy<Result<void>>(Success(data: null));
  });

  setUp(() {
    mockRemoteDataSource = MockTrackOrderRemoteDataSource();
    repository = TrackOrderRepoImpl(mockRemoteDataSource);
  });

  group('TrackOrderRepoImpl Test Group', () {
    const tOrderId = 'order_123';
    const tDriverId = 'driver_456';

    group('watchOrder', () {
      test(
        'should return a stream of TrackOrderEntity and map models correctly',
        () {
          final tResponse = TrackOrderResponse(
            id: tOrderId,
            orderNumber: '1',
            orderStatus: 'pending',
            isActive: true,
            driverId: 'd1',
            totalPrice: 100,
            paymentType: 'cash',
            isPaid: false,
            isDelivered: false,
            state: 'state',
            createdAt: '2023-01-01',
            updatedAt: '2023-01-01',
            paidAt: '2023-01-01',
            v: 1,
            user: User(
              id: 'u1',
              firstName: 'f',
              lastName: 'l',
              email: 'e',
              phone: 'p',
              photo: 'ph',
            ),
            store: Store(
              name: 's',
              image: 'i',
              phoneNumber: 'p',
              address: 'a',
              latLong: '1,2',
            ),
            shippingAddress: ShippingAddress(
              street: 'st',
              city: 'c',
              phone: 'p',
              lat: '1',
              long: '2',
            ),
            orderItems: [],
            currentLocation: CurrentLocation(latitude: 0, longitude: 0),
          );

          when(
            mockRemoteDataSource.watchOrder(tOrderId),
          ).thenAnswer((_) => Stream.value(tResponse));

          final result = repository.watchOrder(tOrderId);

          expect(result, emits(isA<TrackOrderEntity>()));
          verify(mockRemoteDataSource.watchOrder(tOrderId)).called(1);
        },
      );
    });

    group('watchDriver', () {
      test(
        'should return a stream of DriverEntity and map models correctly',
        () {
          final tDriverModel = DriverModel(
            firstName: 'John',
            lastName: 'Doe',
            email: 'j@j.com',
            phone: '123',
          );
          when(
            mockRemoteDataSource.watchDriver(tDriverId),
          ).thenAnswer((_) => Stream.value(tDriverModel));

          final result = repository.watchDriver(tDriverId);

          expect(result, emits(isA<DriverEntity>()));
          verify(mockRemoteDataSource.watchDriver(tDriverId)).called(1);
        },
      );
    });

    group('getRoute', () {
      group('Success Cases', () {
        test(
          'should return Success with RouteEntity when remote data source returns Success',
          () async {
            final tOpenRouteResponse = OpenRouteResponse(
              features: [
                Feature(
                  geometry: Geometry(
                    coordinates: [
                      [0.0, 0.0],
                      [1.0, 1.0],
                    ],
                  ),
                ),
              ],
            );
            when(
              mockRemoteDataSource.getRoute(
                startLat: anyNamed('startLat'),
                startLng: anyNamed('startLng'),
                endLat: anyNamed('endLat'),
                endLng: anyNamed('endLng'),
              ),
            ).thenAnswer((_) async => Success(data: tOpenRouteResponse));

            final result = await repository.getRoute(
              startLat: 0.0,
              startLng: 0.0,
              endLat: 1.0,
              endLng: 1.0,
            );

            expect(result, isA<Success<RouteEntity>>());
            verify(
              mockRemoteDataSource.getRoute(
                startLat: 0.0,
                startLng: 0.0,
                endLat: 1.0,
                endLng: 1.0,
              ),
            ).called(1);
          },
        );
      });

      group('Failure Cases', () {
        test(
          'should return Failure when remote data source returns Failure',
          () async {
            when(
              mockRemoteDataSource.getRoute(
                startLat: anyNamed('startLat'),
                startLng: anyNamed('startLng'),
                endLat: anyNamed('endLat'),
                endLng: anyNamed('endLng'),
              ),
            ).thenAnswer((_) async => Failure(errorMessage: 'Network error'));

            final result = await repository.getRoute(
              startLat: 0.0,
              startLng: 0.0,
              endLat: 0.0,
              endLng: 0.0,
            );

            expect(result, isA<Failure<RouteEntity>>());
            expect((result as Failure).errorMessage, 'Network error');
          },
        );
      });
    });

    group('updateOrderToCompleted', () {
      group('Success Cases', () {
        test(
          'should return Success<void> when remote data source returns Success',
          () async {
            when(
              mockRemoteDataSource.updateOrderToCompleted(tOrderId),
            ).thenAnswer((_) async => Success(data: null));

            final result = await repository.updateOrderToCompleted(tOrderId);

            expect(result, isA<Success<void>>());
            verify(
              mockRemoteDataSource.updateOrderToCompleted(tOrderId),
            ).called(1);
          },
        );
      });

      group('Failure Cases', () {
        test(
          'should return Failure when remote data source returns Failure',
          () async {
            when(
              mockRemoteDataSource.updateOrderToCompleted(tOrderId),
            ).thenAnswer((_) async => Failure(errorMessage: 'Update error'));

            final result = await repository.updateOrderToCompleted(tOrderId);

            expect(result, isA<Failure<void>>());
            expect((result as Failure).errorMessage, 'Update error');
          },
        );
      });
    });
  });
}
