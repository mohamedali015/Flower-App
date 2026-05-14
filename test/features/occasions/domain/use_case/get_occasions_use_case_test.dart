import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasions/domain/repositories/occasions_repo.dart';
import 'package:flower_app/features/occasions/domain/use_case/get_occasions_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_occasions_use_case_test.mocks.dart';

@GenerateMocks([OccasionsRepo])
void main() {
  late GetOccasionsUseCase getOccasionsUseCase;

  late MockOccasionsRepo mockOccasionsRepo;

  late List<OccasionEntity> occasionsEntities;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong. Please try again later.";

    occasionsEntities = List.generate(
      5,
      (index) => OccasionEntity(
        id: index.toString(),
        name: "Occasion $index",
        image: "image_$index.png",
        isSuperAdmin: false,
        productsCount: index,
      ),
    );

    provideDummy<Result<List<OccasionEntity>>>(
      Success<List<OccasionEntity>>(data: occasionsEntities),
    );
  });

  setUp(() {
    mockOccasionsRepo = MockOccasionsRepo();

    getOccasionsUseCase = GetOccasionsUseCase(mockOccasionsRepo);
  });

  group("Get Occasions UseCase Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with occasions returned successfully", () async {
        when(mockOccasionsRepo.getOccasions()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: occasionsEntities),
        );

        final result = await getOccasionsUseCase();

        expect(result, isA<Success<List<OccasionEntity>>>());

        expect(
          (result as Success<List<OccasionEntity>>).data.length,
          occasionsEntities.length,
        );

        verify(mockOccasionsRepo.getOccasions()).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case with error message", () async {
        when(mockOccasionsRepo.getOccasions()).thenAnswer(
          (_) async =>
              Failure<List<OccasionEntity>>(errorMessage: errorMessage),
        );

        final result = await getOccasionsUseCase();

        expect(result, isA<Failure<List<OccasionEntity>>>());

        expect(
          (result as Failure<List<OccasionEntity>>).errorMessage,
          errorMessage,
        );

        verify(mockOccasionsRepo.getOccasions()).called(1);
      });
    });
  });
}
