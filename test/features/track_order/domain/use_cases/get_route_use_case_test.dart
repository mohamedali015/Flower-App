import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/entities/route_entity.dart';
import 'package:flower_app/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_route_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_route_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  late GetRouteUseCase useCase;
  late MockTrackOrderRepo mockRepo;

  setUpAll(() {
    provideDummy<Result<RouteEntity>>(
      Success(data: const RouteEntity(points: [])),
    );
  });

  setUp(() {
    mockRepo = MockTrackOrderRepo();
    useCase = GetRouteUseCase(mockRepo);
  });

  const tRouteEntity = RouteEntity(points: []);

  group('GetRouteUseCase Test Group', () {
    group('Success Cases', () {
      test('should return Success<RouteEntity> from repository', () async {
        when(
          mockRepo.getRoute(
            startLat: anyNamed('startLat'),
            startLng: anyNamed('startLng'),
            endLat: anyNamed('endLat'),
            endLng: anyNamed('endLng'),
          ),
        ).thenAnswer((_) async => Success(data: tRouteEntity));

        final result = await useCase.call(
          startLat: 0,
          startLng: 0,
          endLat: 1,
          endLng: 1,
        );

        expect(result, isA<Success<RouteEntity>>());
        expect((result as Success).data, tRouteEntity);
        verify(
          mockRepo.getRoute(startLat: 0, startLng: 0, endLat: 1, endLng: 1),
        ).called(1);
      });
    });

    group('Failure Cases', () {
      test('should return Failure from repository', () async {
        when(
          mockRepo.getRoute(
            startLat: anyNamed('startLat'),
            startLng: anyNamed('startLng'),
            endLat: anyNamed('endLat'),
            endLng: anyNamed('endLng'),
          ),
        ).thenAnswer((_) async => Failure(errorMessage: 'Route Error'));

        final result = await useCase.call(
          startLat: 0,
          startLng: 0,
          endLat: 1,
          endLng: 1,
        );

        expect(result, isA<Failure<RouteEntity>>());
        expect((result as Failure).errorMessage, 'Route Error');
        verify(
          mockRepo.getRoute(startLat: 0, startLng: 0, endLat: 1, endLng: 1),
        ).called(1);
      });
    });
  });
}
