import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/search/presentation/manager/search_cubit.dart';
import 'package:flower_app/features/search/presentation/manager/search_event.dart';
import 'package:flower_app/features/search/presentation/manager/search_state.dart';
import 'search_cubit.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  late MockGetProductsUseCase mockGetProductsUseCase;

  const tResponse = ProductsResponseEntity(
    products: [],
    metadata: MetadataEntity(
      currentPage: 1,
      totalPages: 1,
      limit: 10,
      totalItems: 0,
    ),
  );

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    provideDummy<Result<ProductsResponseEntity>>(
       Success(data: tResponse),
    );
  });

  group('SearchCubit', () {
    ///? Initial state
    test('initial state should be SearchState()', () {
      final cubit = SearchCubit(mockGetProductsUseCase);
      expect(cubit.state, const SearchState());
      cubit.close();
    });

    ///? Empty search
    blocTest<SearchCubit, SearchState>(
      'emits cleared state when search text is empty',
      build: () => SearchCubit(mockGetProductsUseCase),
      act: (cubit) => cubit.getSearchEvent(
        SearchProductEvent(
          search: const ProductQueryParams(search: ''),
        ),
      ),
      expect: () => [
        const SearchState(
          searchProducts: [],
          isSearchProductLoading: false,
          searchProductErrorMessage: null,
        ),
      ],
      verify: (_) => verifyNever(
        mockGetProductsUseCase(params: anyNamed('params')),
      ),
    );

    ///? Success
    blocTest<SearchCubit, SearchState>(
      'emits [loading, success] when search succeeds',
      build: () {
        when(mockGetProductsUseCase(params: anyNamed('params')))
            .thenAnswer((_) async =>  Success(data: tResponse));
        return SearchCubit(mockGetProductsUseCase);
      },
      act: (cubit) => cubit.getSearchEvent(
        SearchProductEvent(
          search: const ProductQueryParams(search: 'rose'),
        ),
      ),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const SearchState(
          isSearchProductLoading: true,
          searchProductErrorMessage: null,
        ),
        const SearchState(
          searchProducts: [],
          isSearchProductLoading: false,
          searchProductErrorMessage: null,
        ),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(params: anyNamed('params'))).called(1);
        verifyNoMoreInteractions(mockGetProductsUseCase);
      },
    );

    ///? Failure
    blocTest<SearchCubit, SearchState>(
      'emits [loading, failure] when search fails',
      build: () {
        when(mockGetProductsUseCase(params: anyNamed('params')))
            .thenAnswer((_) async =>  Failure(errorMessage: 'Server Error'));
        return SearchCubit(mockGetProductsUseCase);
      },
      act: (cubit) => cubit.getSearchEvent(
        SearchProductEvent(
          search: const ProductQueryParams(search: 'rose'),
        ),
      ),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const SearchState(
          isSearchProductLoading: true,
          searchProductErrorMessage: null,
        ),
        const SearchState(
          isSearchProductLoading: false,
          searchProductErrorMessage: 'Server Error',
        ),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(params: anyNamed('params'))).called(1);
        verifyNoMoreInteractions(mockGetProductsUseCase);
      },
    );

    ///? clearSearch
    blocTest<SearchCubit, SearchState>(
      'clearSearch emits cleared state',
      build: () => SearchCubit(mockGetProductsUseCase),
      act: (cubit) => cubit.clearSearch(),
      expect: () => [
        const SearchState(
          searchProducts: [],
          isSearchProductLoading: false,
          searchProductErrorMessage: null,
        ),
      ],
    );

    ///? Debounce
    blocTest<SearchCubit, SearchState>(
      'debounce: only calls use case once for rapid searches',
      build: () {
        when(mockGetProductsUseCase(params: anyNamed('params')))
            .thenAnswer((_) async =>  Success(data: tResponse));
        return SearchCubit(mockGetProductsUseCase);
      },
      act: (cubit) {
        cubit.getSearchEvent(
          SearchProductEvent(search: const ProductQueryParams(search: 'r')),
        );
        cubit.getSearchEvent(
          SearchProductEvent(search: const ProductQueryParams(search: 'ro')),
        );
        cubit.getSearchEvent(
          SearchProductEvent(search: const ProductQueryParams(search: 'rose')),
        );
      },
      wait: const Duration(milliseconds: 600),
      verify: (_) {
        verify(mockGetProductsUseCase(params: anyNamed('params'))).called(1);
      },
    );
  });
}