import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/add_to_cart/domain/use_case/add_cart_use_case.dart';
import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_cubit.dart';
import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_event.dart';
import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_state.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'add_cart_cubit_test.mocks.dart';

@GenerateMocks([AddCartUseCase])
void main() {
  late MockAddCartUseCase mockUseCase;
  late AddCartCubit cubit;

  setUpAll(() {
    provideDummy<Result<GetCartEntity>>(
      Failure<GetCartEntity>(errorMessage: 'dummy'),
    );
  });

  setUp(() {
    mockUseCase = MockAddCartUseCase();
    cubit = AddCartCubit(mockUseCase);
  });

  final request = AddToCartRequest(product: "1", quantity: 2);

  final entity = GetCartEntity(
    numOfCartItems: null,
    totalPrice: null,
    totalPriceAfterDiscount: null,
    cartItems: [],
    // fill required fields
  );

  group('AddCartCubit Tests', () {
    blocTest<AddCartCubit, AddCartState>(
      'emits loading then success state when add to cart succeeds',
      build: () {
        when(
          mockUseCase.call(request),
        ).thenAnswer((_) async => Success<GetCartEntity>(data: entity));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(AddToCart(request)),
      expect: () => [
        // loading
        isA<AddCartState>(),
        // success
        isA<AddCartState>(),
      ],
      verify: (_) {
        verify(mockUseCase.call(request)).called(1);
      },
    );

    blocTest<AddCartCubit, AddCartState>(
      'emits loading then failure state when add to cart fails',
      build: () {
        when(mockUseCase.call(request)).thenAnswer(
          (_) async => Failure<GetCartEntity>(errorMessage: 'Server Error'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(AddToCart(request)),
      expect: () => [
        isA<AddCartState>(), // loading
        isA<AddCartState>(), // error
      ],
      verify: (_) {
        verify(mockUseCase.call(request)).called(1);
      },
    );
  });
}
