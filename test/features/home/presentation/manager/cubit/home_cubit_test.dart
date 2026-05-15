import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/use_cases/get_home_use_case.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_events.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetHomeUseCase])
void main() {
  late HomeCubit homeCubit;
  late MockGetHomeUseCase mockGetHomeUseCase;
  late HomeResponseEntity homeResponseEntity;
  late String errorMessage;

  setUpAll(() {
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

  setUp(() {
    mockGetHomeUseCase = MockGetHomeUseCase();
    homeCubit = HomeCubit(mockGetHomeUseCase);
  });

  group('HomeCubit', () {
    test('initial state should be HomeInitial', () {
      expect(homeCubit.state, isA<HomeInitial>());
    });

    blocTest<HomeCubit, HomeState>(
      'should emit loading then success when GetHomeEvent succeeds',
      setUp: () {
        when(mockGetHomeUseCase()).thenAnswer(
          (_) async => Success<HomeResponseEntity>(data: homeResponseEntity),
        );
      },
      build: () => homeCubit,
      act: (cubit) => cubit.doEvents(GetHomeEvent()),
      expect: () => [
        isA<HomeLoading>(),
        HomeSuccess(homeResponseEntity: homeResponseEntity),
      ],
      verify: (_) {
        verify(mockGetHomeUseCase()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'should emit loading then failure when GetHomeEvent fails',
      setUp: () {
        when(mockGetHomeUseCase()).thenAnswer(
          (_) async => Failure<HomeResponseEntity>(errorMessage: errorMessage),
        );
      },
      build: () => homeCubit,
      act: (cubit) => cubit.doEvents(GetHomeEvent()),
      expect: () => [
        isA<HomeLoading>(),
        HomeFailure(errorMessage: errorMessage),
      ],
      verify: (_) {
        verify(mockGetHomeUseCase()).called(1);
      },
    );
  });
}
