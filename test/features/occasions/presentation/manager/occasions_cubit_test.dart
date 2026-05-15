import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasions/domain/use_case/get_occasions_use_case.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_cubit.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_events.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasions_cubit_test.mocks.dart';

@GenerateMocks([GetOccasionsUseCase, GetProductsUseCase])
void main() {
  late OccasionsCubit occasionsCubit;

  late MockGetOccasionsUseCase mockGetOccasionsUseCase;

  late MockGetProductsUseCase mockGetProductsUseCase;

  late List<OccasionEntity> occasionsEntities;

  late ProductsResponseEntity productsResponseEntity;

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

    productsResponseEntity = ProductsResponseEntity(
      products: [
        ProductEntity(
          id: "1",
          title: "Rose",
          slug: "",
          description: "",
          imgCover: "",
          images: const [],
          price: 100,
          priceAfterDiscount: 0,
          discount: 0,
          rateAvg: 0,
          rateCount: 0,
          sold: 0,
          quantity: 0,
          category: "",
          occasion: "",
          isSuperAdmin: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0,
          favoriteId: "",
          isInWishlist: false,
        ),
      ],
      metadata: MetadataEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 1,
      ),
    );

    provideDummy<Result<List<OccasionEntity>>>(
      Success<List<OccasionEntity>>(data: occasionsEntities),
    );

    provideDummy<Result<ProductsResponseEntity>>(
      Success<ProductsResponseEntity>(data: productsResponseEntity),
    );
  });

  setUp(() {
    mockGetOccasionsUseCase = MockGetOccasionsUseCase();

    mockGetProductsUseCase = MockGetProductsUseCase();

    occasionsCubit = OccasionsCubit(
      mockGetProductsUseCase,
      mockGetOccasionsUseCase,
    );
  });

  group("Occasions Cubit Test Group", () {
    test("initial state should be OccasionsState", () {
      expect(occasionsCubit.state, OccasionsState());
    });

    blocTest<OccasionsCubit, OccasionsState>(
      "should emit loading then success when get occasions succeeds",

      setUp: () {
        when(mockGetOccasionsUseCase()).thenAnswer(
          (_) async => Success<List<OccasionEntity>>(data: occasionsEntities),
        );
      },

      build: () => occasionsCubit,

      act: (cubit) {
        cubit.doEvent(GetOccasionsCategoriesEvent());
      },

      expect: () => [
        OccasionsState().copyWith(
          occasionsCategoryStateParam: OccasionsState().occasionsCategoryState
              .copyWith(isLoadingParam: true),
        ),

        OccasionsState().copyWith(
          occasionsCategoryStateParam: OccasionsState().occasionsCategoryState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: true,
                dataParam: occasionsEntities,
              ),
        ),
      ],

      verify: (_) {
        verify(mockGetOccasionsUseCase()).called(1);
      },
    );

    blocTest<OccasionsCubit, OccasionsState>(
      "should emit loading then failure when get occasions fails",

      setUp: () {
        when(mockGetOccasionsUseCase()).thenAnswer(
          (_) async =>
              Failure<List<OccasionEntity>>(errorMessage: errorMessage),
        );
      },

      build: () => occasionsCubit,

      act: (cubit) {
        cubit.doEvent(GetOccasionsCategoriesEvent());
      },

      expect: () => [
        OccasionsState().copyWith(
          occasionsCategoryStateParam: OccasionsState().occasionsCategoryState
              .copyWith(isLoadingParam: true),
        ),

        OccasionsState().copyWith(
          occasionsCategoryStateParam: OccasionsState().occasionsCategoryState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: false,
                errorMessageParam: errorMessage,
              ),
        ),
      ],

      verify: (_) {
        verify(mockGetOccasionsUseCase()).called(1);

        verifyNoMoreInteractions(mockGetOccasionsUseCase);
      },
    );

    blocTest<OccasionsCubit, OccasionsState>(
      "should emit loading then success when get products succeeds",

      setUp: () {
        when(mockGetProductsUseCase(params: anyNamed('params'))).thenAnswer(
          (_) async =>
              Success<ProductsResponseEntity>(data: productsResponseEntity),
        );
      },

      build: () => occasionsCubit,

      act: (cubit) {
        cubit.doEvent(GetOccasionProductsEvent(occasionId: "1"));
      },

      expect: () => [
        OccasionsState().copyWith(
          occasionProductsStateParam: OccasionsState().occasionProductsState
              .copyWith(isLoadingParam: true),
        ),

        OccasionsState().copyWith(
          occasionProductsStateParam: OccasionsState().occasionProductsState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: true,
                dataParam: productsResponseEntity,
              ),
        ),
      ],

      verify: (_) {
        verify(mockGetProductsUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockGetProductsUseCase);
      },
    );

    blocTest<OccasionsCubit, OccasionsState>(
      "should emit loading then failure when get products fails",

      setUp: () {
        when(mockGetProductsUseCase(params: anyNamed('params'))).thenAnswer(
          (_) async =>
              Failure<ProductsResponseEntity>(errorMessage: errorMessage),
        );
      },

      build: () => occasionsCubit,

      act: (cubit) {
        cubit.doEvent(GetOccasionProductsEvent(occasionId: "1"));
      },

      expect: () => [
        OccasionsState().copyWith(
          occasionProductsStateParam: OccasionsState().occasionProductsState
              .copyWith(isLoadingParam: true),
        ),

        OccasionsState().copyWith(
          occasionProductsStateParam: OccasionsState().occasionProductsState
              .copyWith(
                isLoadingParam: false,
                isSuccessParam: false,
                errorMessageParam: errorMessage,
              ),
        ),
      ],

      verify: (_) {
        verify(mockGetProductsUseCase(params: anyNamed('params'))).called(1);

        verifyNoMoreInteractions(mockGetProductsUseCase);
      },
    );
  });
}
