import 'package:flower_app/config/data_base/data_base_service.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/api/data_sources/remote/track_order_remote_data_source_impl.dart';
import 'package:flower_app/features/track_order/api/open_route_api_client.dart';
import 'package:flower_app/features/track_order/data/models/remote/open_route_response.dart';
import 'package:flower_app/features/track_order/data/models/response/driver_model.dart';
import 'package:flower_app/features/track_order/data/models/response/track_order_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([DatabaseService, OpenRouteApiClient])
void main() {
  late TrackOrderRemoteDataSourceImpl dataSource;
  late MockDatabaseService mockDatabaseService;
  late MockOpenRouteApiClient mockOpenRouteApiClient;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    mockOpenRouteApiClient = MockOpenRouteApiClient();
    dataSource = TrackOrderRemoteDataSourceImpl(
      mockDatabaseService,
      mockOpenRouteApiClient,
    );
  });

  group('TrackOrderRemoteDataSourceImpl Test Group', () {
    const tOrderId = 'order_123';
    const tDriverId = 'driver_456';

    group('watchOrder', () {
      test(
        'should return a stream of TrackOrderResponse when database watch is successful',
        () {
          final tResponse = TrackOrderResponse(id: tOrderId);
          when(
            mockDatabaseService.watchDocument<TrackOrderResponse>(
              path: anyNamed('path'),
              fromFirestore: anyNamed('fromFirestore'),
            ),
          ).thenAnswer((_) => Stream.value(tResponse));

          final result = dataSource.watchOrder(tOrderId);

          expect(result, emits(tResponse));
          verify(
            mockDatabaseService.watchDocument<TrackOrderResponse>(
              path: argThat(contains(tOrderId), named: 'path'),
              fromFirestore: anyNamed('fromFirestore'),
            ),
          ).called(1);
        },
      );
    });

    group('watchDriver', () {
      test(
        'should return a stream of DriverModel when database watch is successful',
        () {
          final tDriver = DriverModel(firstName: 'John');
          when(
            mockDatabaseService.watchDocument<DriverModel>(
              path: anyNamed('path'),
              fromFirestore: anyNamed('fromFirestore'),
            ),
          ).thenAnswer((_) => Stream.value(tDriver));

          final result = dataSource.watchDriver(tDriverId);

          expect(result, emits(tDriver));
          verify(
            mockDatabaseService.watchDocument<DriverModel>(
              path: argThat(contains(tDriverId), named: 'path'),
              fromFirestore: anyNamed('fromFirestore'),
            ),
          ).called(1);
        },
      );
    });

    group('getRoute', () {
      group('Success Cases', () {
        test(
          'should return Success<OpenRouteResponse> when API call is successful',
          () async {
            final tOpenRouteResponse = OpenRouteResponse();
            when(
              mockOpenRouteApiClient.getRoute(
                apiKey: anyNamed('apiKey'),
                start: anyNamed('start'),
                end: anyNamed('end'),
              ),
            ).thenAnswer((_) async => tOpenRouteResponse);

            final result = await dataSource.getRoute(
              startLat: 10.0,
              startLng: 20.0,
              endLat: 30.0,
              endLng: 40.0,
            );

            expect(result, isA<Success<OpenRouteResponse>>());
            expect((result as Success).data, tOpenRouteResponse);
            verify(
              mockOpenRouteApiClient.getRoute(
                apiKey: anyNamed('apiKey'),
                start: '20.0,10.0',
                end: '40.0,30.0',
              ),
            ).called(1);
          },
        );
        group('Failure Cases', () {
          test(
            'should return Failure when API call throws an exception',
            () async {
              when(
                mockOpenRouteApiClient.getRoute(
                  apiKey: anyNamed('apiKey'),
                  start: anyNamed('start'),
                  end: anyNamed('end'),
                ),
              ).thenThrow(Exception('API Error'));

              final result = await dataSource.getRoute(
                startLat: 0.0,
                startLng: 0.0,
                endLat: 0.0,
                endLng: 0.0,
              );

              expect(result, isA<Failure<OpenRouteResponse>>());
            },
          );
        });
      });
    });

    group('updateOrderToCompleted', () {
      group('Success Cases', () {
        test(
          'should return Success<void> when database update is successful',
          () async {
            when(
              mockDatabaseService.updateData(
                path: anyNamed('path'),
                data: anyNamed('data'),
              ),
            ).thenAnswer((_) async => {});

            final result = await dataSource.updateOrderToCompleted(tOrderId);

            expect(result, isA<Success<void>>());
            verify(
              mockDatabaseService.updateData(
                path: argThat(contains(tOrderId), named: 'path'),
                data: argThat(containsValue('completed'), named: 'data'),
              ),
            ).called(1);
          },
        );
      });

      group('Failure Cases', () {
        test(
          'should return Failure when database update throws an exception',
          () async {
            when(
              mockDatabaseService.updateData(
                path: anyNamed('path'),
                data: anyNamed('data'),
              ),
            ).thenThrow(Exception('Update failed'));

            final result = await dataSource.updateOrderToCompleted(tOrderId);

            expect(result, isA<Failure<void>>());
            expect((result as Failure).errorMessage, contains('Update failed'));
          },
        );
      });
    });
  });
}
