import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/category/domain/entities/get_all_category_entity.dart';
import 'package:flower_app/features/category/domain/use_case/get_category_use_case.dart';
import 'package:flower_app/features/category/presentation/manager/category_cubit.dart';
import 'package:flower_app/features/category/presentation/manager/category_event.dart';
import 'package:flower_app/features/category/presentation/manager/category_state.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_cubit_test.mocks.dart';

@GenerateMocks([GetCategoryUseCase, GetProductsUseCase])
void main() {
  late MockGetCategoryUseCase mockGetCategoryUseCase;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late CategoryCubit categoryCubit;

  final tCategories = [
    const GetAllCategoryEntity(
      id: 'cat1',
      name: 'Category 1',
      image: '',
      isSuperAdmin: false,
      productsCount: 5,
    ),
  ];

  final tProducts = [
    ProductEntity(
      id: 'prod1',
      title: 'Product 1',
      slug: '',
      description: '',
      imgCover: '',
      images: const [],
      price: 100,
      priceAfterDiscount: 0,
      discount: 0,
      rateAvg: 0,
      rateCount: 0,
      sold: 0,
      quantity: 0,
      category: 'cat1',
      occasion: '',
      isSuperAdmin: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      v: 0,
      favoriteId: '',
      isInWishlist: false,
    ),
  ];

  final tProductsResponse = ProductsResponseEntity(
    products: tProducts,
    metadata: const MetadataEntity(
      currentPage: 1,
      totalPages: 1,
      limit: 10,
      totalItems: 1,
    ),
  );

  setUpAll(() {
    provideDummy<Result<List<GetAllCategoryEntity>>>(
      Success(data: tCategories),
    );
    provideDummy<Result<ProductsResponseEntity>>(
      Success(data: tProductsResponse),
    );
  });

  setUp(() {
    mockGetCategoryUseCase = MockGetCategoryUseCase();
    mockGetProductsUseCase = MockGetProductsUseCase();
    categoryCubit = CategoryCubit(mockGetCategoryUseCase, mockGetProductsUseCase);
  });

  tearDown(() {
    categoryCubit.close();
  });

  group('CategoryCubit Tests', () {
    test('initial state should be CategoryState()', () {
      expect(categoryCubit.state, const CategoryState());
    });

    group('GetAllCategoryEvent Tests', () {
      blocTest<CategoryCubit, CategoryState>(
        'emits categoriesState with isLoading=true, then success status and categories data',
        build: () {
          when(mockGetCategoryUseCase.getAllCategories())
              .thenAnswer((_) async => Success(data: tCategories));
          return categoryCubit;
        },
        act: (cubit) => cubit.doEvent(GetAllCategoryEvent()),
        expect: () => [
          const CategoryState(
            categoriesState: BaseState(isLoading: true),
          ),
          CategoryState(
            categoriesState: BaseState(
              isLoading: false,
              isSuccess: true,
              data: tCategories,
            ),
          ),
        ],
        verify: (_) {
          verify(mockGetCategoryUseCase.getAllCategories()).called(1);
        },
      );

      blocTest<CategoryCubit, CategoryState>(
        'emits categoriesState with isLoading=true, then failure status and errorMessage',
        build: () {
          when(mockGetCategoryUseCase.getAllCategories())
              .thenAnswer((_) async => Failure(errorMessage: 'Network Error'));
          return categoryCubit;
        },
        act: (cubit) => cubit.doEvent(GetAllCategoryEvent()),
        expect: () => [
          const CategoryState(
            categoriesState: BaseState(isLoading: true),
          ),
          const CategoryState(
            categoriesState: BaseState(
              isLoading: false,
              isSuccess: false,
              errorMessage: 'Network Error',
            ),
          ),
        ],
      );
    });

    group('ProductEvent (Filtering & Sorting) Tests', () {
      final tParams = const ProductQueryParams(
        categoryId: 'cat1',
        sort: SortOption.lowestPrice,
      );

      blocTest<CategoryCubit, CategoryState>(
        'emits productsState with isLoading=true, then success status and products data with selected filter params',
        build: () {
          when(mockGetProductsUseCase.call(params: anyNamed('params')))
              .thenAnswer((_) async => Success(data: tProductsResponse));
          return categoryCubit;
        },
        act: (cubit) => cubit.doEvent(ProductEvent(categoryId: tParams)),
        expect: () => [
          const CategoryState(
            productsState: BaseState(isLoading: true),
            selectedCategoryId: 'cat1',
            selectedSortOption: SortOption.lowestPrice,
          ),
          CategoryState(
            productsState: BaseState(
              isLoading: false,
              isSuccess: true,
              data: tProducts,
            ),
            selectedCategoryId: 'cat1',
            selectedSortOption: SortOption.lowestPrice,
          ),
        ],
        verify: (_) {
          verify(mockGetProductsUseCase.call(params: tParams)).called(1);
        },
      );

      blocTest<CategoryCubit, CategoryState>(
        'emits productsState with isLoading=true, then failure status when use case fails',
        build: () {
          when(mockGetProductsUseCase.call(params: anyNamed('params')))
              .thenAnswer((_) async => Failure(errorMessage: 'Filter error'));
          return categoryCubit;
        },
        act: (cubit) => cubit.doEvent(ProductEvent(categoryId: tParams)),
        expect: () => [
          const CategoryState(
            productsState: BaseState(isLoading: true),
            selectedCategoryId: 'cat1',
            selectedSortOption: SortOption.lowestPrice,
          ),
          const CategoryState(
            productsState: BaseState(
              isLoading: false,
              isSuccess: false,
              errorMessage: 'Filter error',
            ),
            selectedCategoryId: 'cat1',
            selectedSortOption: SortOption.lowestPrice,
          ),
        ],
      );
    });
  });
}
