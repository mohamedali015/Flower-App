import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/api/data_source/remote/occasions_remote_data_source_impl.dart';
import 'package:flower_app/features/occasions/api/occasions_api_client.dart';
import 'package:flower_app/features/occasions/data/model/response/occasion_model.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasions_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OccasionsApiClient])
void main() {
  late OccasionsRemoteDataSourceImpl occasionsRemoteDataSourceImpl;

  late MockOccasionsApiClient mockOccasionsApiClient;

  late OccasionsResponse occasionsResponse;

  late List<OccasionModel> occasionsModels;

  setUpAll(() {
    occasionsModels = List.generate(
      5,
      (index) => OccasionModel(
        id: index.toString(),
        name: "Occasion $index",
        image: "image_$index.png",
      ),
    );

    occasionsResponse = OccasionsResponse(occasions: occasionsModels);
  });

  setUp(() {
    mockOccasionsApiClient = MockOccasionsApiClient();

    occasionsRemoteDataSourceImpl = OccasionsRemoteDataSourceImpl(
      mockOccasionsApiClient,
    );
  });

  group("Get Occasions Function Test Group", () {
    group("Success Cases", () {
      test("Test Success Case with occasions returned successfully", () async {
        when(
          mockOccasionsApiClient.getOccasions(),
        ).thenAnswer((_) async => occasionsResponse);

        final result = await occasionsRemoteDataSourceImpl.getOccasions();

        expect(result, isA<Success<OccasionsResponse>>());

        expect(
          (result as Success<OccasionsResponse>).data.occasions?.length,
          occasionsModels.length,
        );

        verify(mockOccasionsApiClient.getOccasions()).called(1);
      });
    });

    group("Failure Cases", () {
      test("Test Failure Case when api throws exception", () async {
        when(mockOccasionsApiClient.getOccasions()).thenThrow(Exception());

        final result = await occasionsRemoteDataSourceImpl.getOccasions();

        expect(result, isA<Failure<OccasionsResponse>>());

        expect((result as Failure<OccasionsResponse>).errorMessage, isNotEmpty);

        verify(mockOccasionsApiClient.getOccasions()).called(1);
      });
    });
  });
}
