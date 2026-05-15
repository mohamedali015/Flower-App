import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/data/data_source/remote/occasions_remote_data_source.dart';
import 'package:flower_app/features/occasions/data/model/response/occasion_model.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';
import 'package:flower_app/features/occasions/data/repositories/occasions_repo_impl.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasions_repo_impl_test.mocks.dart';

@GenerateMocks([OccasionsRemoteDataSource])
void main() {
  late OccasionsRepoImpl occasionsRepoImpl;

  late MockOccasionsRemoteDataSource mockOccasionsRemoteDataSource;

  late List<OccasionModel> occasionsModels;

  late OccasionsResponse occasionsResponse;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong. Please try again later.";

    occasionsModels = List.generate(
      5,
      (index) => OccasionModel(
        id: index.toString(),
        name: "Occasion $index",
        image: "image_$index.png",
        productsCount: index,
      ),
    );

    occasionsResponse = OccasionsResponse(occasions: occasionsModels);

    provideDummy<Result<OccasionsResponse>>(
      Success<OccasionsResponse>(data: occasionsResponse),
    );
  });

  setUp(() {
    mockOccasionsRemoteDataSource = MockOccasionsRemoteDataSource();

    occasionsRepoImpl = OccasionsRepoImpl(mockOccasionsRemoteDataSource);
  });

  group("Get Occasions Function Test Group", () {
    group("Success Cases", () {
      test(
        "Test Success Case with mapped entities returned successfully",
        () async {
          when(mockOccasionsRemoteDataSource.getOccasions()).thenAnswer(
            (_) async => Success<OccasionsResponse>(data: occasionsResponse),
          );

          final result = await occasionsRepoImpl.getOccasions();

          expect(result, isA<Success<List<OccasionEntity>>>());

          expect(
            (result as Success<List<OccasionEntity>>).data.length,
            occasionsModels.length,
          );

          expect(result.data[0].name, occasionsModels[0].name);

          expect(result.data.last.name, occasionsModels.last.name);

          verify(mockOccasionsRemoteDataSource.getOccasions()).called(1);
        },
      );
    });

    group("Failure Cases", () {
      test("Test Failure Case with error message", () async {
        when(mockOccasionsRemoteDataSource.getOccasions()).thenAnswer(
          (_) async => Failure<OccasionsResponse>(errorMessage: errorMessage),
        );

        final result = await occasionsRepoImpl.getOccasions();

        expect(result, isA<Failure<List<OccasionEntity>>>());

        expect(
          (result as Failure<List<OccasionEntity>>).errorMessage,
          errorMessage,
        );

        verify(mockOccasionsRemoteDataSource.getOccasions()).called(1);
      });
    });
  });
}
