import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_cubit.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_event.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'best_seller_cubit_test.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  late BestSellerCubit cubit;
  late MockGetProductsUseCase mockGetProductsUseCase;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    cubit = BestSellerCubit(mockGetProductsUseCase);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('BestSellerCubit Tests', () {
    test('الحالة الابتدائية لازم تكون صحيحة', () {
      expect(cubit.state, const BestSellerState());
    });

    blocTest<BestSellerCubit, BestSellerState>(
      'يجب emit loading ثم success عند نجاح العملية',
      build: () {
        when(
          mockGetProductsUseCase.call(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => Success<ProductsResponseEntity>(
            data: const ProductsResponseEntity(
              products: [],
              metadata: MetadataEntity(
                currentPage: 1,
                totalPages: 1,
                limit: 1,
                totalItems: 1,
              ),
            ),
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetBestSellerEvent()),
      expect: () => [
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.isLoading,
          'loading',
          true,
        ),
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.isSuccess,
          'success',
          true,
        ),
      ],
    );

    blocTest<BestSellerCubit, BestSellerState>(
      'يجب emit loading ثم failure عند حدوث خطأ',
      build: () {
        when(
          mockGetProductsUseCase.call(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => Failure(errorMessage: 'Error fetching products'),
        );

        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetBestSellerEvent()),
      expect: () => [
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.isLoading,
          'loading',
          true,
        ),
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.errorMessage,
          'error message',
          'Error fetching products',
        ),
      ],
    );
  });
}
