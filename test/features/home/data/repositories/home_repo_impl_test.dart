import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/home/api/data_source/home_data_source_impl.dart';
import 'package:flower_app/features/logout/home/data/model/home_response.dart';
import 'package:flower_app/features/logout/home/data/repositories/home_repo_impl.dart';
import 'package:flower_app/features/logout/home/domain/entities/home_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeDataSourceImpl])
void main() {
  late HomeRepoImpl homeRepoImpl;
  late MockHomeDataSourceImpl mockHomeDataSourceImpl;
  late HomeResponse homeResponse;
  late String errorMessage;

  setUpAll(() {
    errorMessage = 'Something went wrong. Please try again later.';

    provideDummy<Result<HomeResponse>>(
      Success<HomeResponse>(data: HomeResponse()),
    );
  });

  setUp(() {
    mockHomeDataSourceImpl = MockHomeDataSourceImpl();
    homeRepoImpl = HomeRepoImpl(mockHomeDataSourceImpl);

    homeResponse = HomeResponse(
      message: 'Success',
      products: const [],
      categories: const [],
      bestSeller: const [],
      occasions: const [],
    );
  });

  group('HomeRepoImpl', () {
    test(
      'should return Success<HomeResponseEntity> when data source returns Success<HomeResponse>',
      () async {
        when(
          mockHomeDataSourceImpl.getHome(),
        ).thenAnswer((_) async => Success<HomeResponse>(data: homeResponse));

        final result = await homeRepoImpl.getHome();

        expect(result, isA<Success<HomeResponseEntity>>());

        final success = result as Success<HomeResponseEntity>;
        expect(success.data.message, homeResponse.message);
        expect(success.data.products, isEmpty);
        expect(success.data.categories, isEmpty);
        expect(success.data.bestSeller, isEmpty);
        expect(success.data.occasions, isEmpty);

        verify(mockHomeDataSourceImpl.getHome()).called(1);
      },
    );

    test(
      'should return Failure<HomeResponseEntity> when data source returns Failure<HomeResponse>',
      () async {
        when(mockHomeDataSourceImpl.getHome()).thenAnswer(
          (_) async => Failure<HomeResponse>(errorMessage: errorMessage),
        );

        final result = await homeRepoImpl.getHome();

        expect(result, isA<Failure<HomeResponseEntity>>());
        expect(
          (result as Failure<HomeResponseEntity>).errorMessage,
          errorMessage,
        );

        verify(mockHomeDataSourceImpl.getHome()).called(1);
      },
    );
  });
}
