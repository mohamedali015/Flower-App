import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/home/api/data_source/home_data_source_impl.dart';
import 'package:flower_app/features/logout/home/api/home_api_client.dart';
import 'package:flower_app/features/logout/home/data/model/home_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  late HomeDataSourceImpl homeDataSourceImpl;
  late MockHomeApiClient mockHomeApiClient;
  late HomeResponse homeResponse;

  setUpAll(() {
    provideDummy<Result<HomeResponse>>(
      Success<HomeResponse>(data: HomeResponse()),
    );

    mockHomeApiClient = MockHomeApiClient();
    homeDataSourceImpl = HomeDataSourceImpl(mockHomeApiClient);

    homeResponse = HomeResponse(
      message: 'Success',
      products: const [],
      categories: const [],
      bestSeller: const [],
      occasions: const [],
    );
  });

  group('HomeDataSourceImpl', () {
    test(
      'should return Success when API client returns HomeResponse',
      () async {
        when(mockHomeApiClient.getHome()).thenAnswer((_) async => homeResponse);
        final result = await homeDataSourceImpl.getHome();
        expect(result, isA<Success<HomeResponse>>());
        expect(
          (result as Success<HomeResponse>).data.message,
          homeResponse.message,
        );
        verify(mockHomeApiClient.getHome()).called(1);
      },
    );

    test('should return Failure when API client throws an exception', () async {
      when(mockHomeApiClient.getHome()).thenThrow(Exception('network error'));
      final result = await homeDataSourceImpl.getHome();
      expect(result, isA<Failure<HomeResponse>>());
      expect((result as Failure<HomeResponse>).errorMessage, isNotNull);
      verify(mockHomeApiClient.getHome()).called(1);
    });
  });
}
