import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repositories/home_repo.dart';
import 'package:flower_app/features/home/domain/use_cases/get_home_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_use_case_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late GetHomeUseCase getHomeUseCase;
  late MockHomeRepo mockHomeRepo;
  late HomeResponseEntity homeResponseEntity;
  late String errorMessage;

  setUpAll(() {
    mockHomeRepo = MockHomeRepo();
    getHomeUseCase = GetHomeUseCase(mockHomeRepo);
    errorMessage = 'Something went wrong. Please try again later.';

    homeResponseEntity = const HomeResponseEntity(
      message: 'Success',
      products: [],
      categories: [],
      bestSeller: [],
      occasions: [],
    );

    provideDummy<Result<HomeResponseEntity>>(
      Success<HomeResponseEntity>(data: homeResponseEntity),
    );
  });

  group('GetHomeUseCase', () {
    test('should return Success when repository returns Success', () async {
      when(mockHomeRepo.getHome()).thenAnswer(
        (_) async => Success<HomeResponseEntity>(data: homeResponseEntity),
      );

      final result = await getHomeUseCase();

      expect(result, isA<Success<HomeResponseEntity>>());
      expect((result as Success<HomeResponseEntity>).data.message, 'Success');
      verify(mockHomeRepo.getHome()).called(1);
    });

    test('should return Failure when repository returns Failure', () async {
      when(mockHomeRepo.getHome()).thenAnswer(
        (_) async => Failure<HomeResponseEntity>(errorMessage: errorMessage),
      );

      final result = await getHomeUseCase();

      expect(result, isA<Failure<HomeResponseEntity>>());
      expect(
        (result as Failure<HomeResponseEntity>).errorMessage,
        errorMessage,
      );
      verify(mockHomeRepo.getHome()).called(1);
    });
  });
}
