import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_cubit.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_event.dart';
import 'package:flower_app/features/best_seller/presentation/manager/best_seller_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProductsUseCase extends Mock implements GetProductsUseCase {}

void main() {
  late BestSellerCubit cubit;
  late MockGetProductsUseCase mockGetProductsUseCase;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    cubit = BestSellerCubit(mockGetProductsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('BestSellerCubit Tests', () {
    test('الحالة الابتدائية (Initial State) لازم تكون صحيحة', () {
      expect(cubit.state, const BestSellerState());
    });

    blocTest<BestSellerCubit, BestSellerState>(
      'يجب أن يخرج (emit) حالة التحميل ثم حالة النجاح عند استدعاء GetBestSellerEvent بنجاح',
      build: () {
        when(
          () => mockGetProductsUseCase.call(params: any(named: 'params')),
        ).thenAnswer(
          (_) async => Success<ProductsResponseEntity>(
            data: ProductsResponseEntity(
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
        // الحالة الأولى: Loading
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.isLoading,
          'loading',
          true,
        ),
        // الحالة الثانية: Success
        isA<BestSellerState>().having(
          (s) => s.bestSellerState.isSuccess,
          'success',
          true,
        ),
      ],
    );

    blocTest<BestSellerCubit, BestSellerState>(
      'يجب أن يخرج (emit) حالة التحميل ثم حالة الفشل عند حدوث خطأ',
      build: () {
        // تجهيز الـ Mock ليرجع فشل
        when(
          () => mockGetProductsUseCase.call(params: any(named: 'params')),
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
