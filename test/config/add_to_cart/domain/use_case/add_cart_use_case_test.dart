import 'package:flower_app/config/add_to_cart/domain/repositories/add_to_cart_repo.dart';
import 'package:flower_app/config/add_to_cart/domain/use_case/add_cart_use_case.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_cart_use_case_test.mocks.dart';

@GenerateMocks([AddToCartRepo])
void main() {
  late MockAddToCartRepo mockRepo;
  late AddCartUseCase useCase;

  setUpAll(() {
    provideDummy<Result<GetCartEntity>>(
      Failure<GetCartEntity>(
        errorMessage: 'dummy',
      ),
    );
  });

  setUp(() {
    mockRepo = MockAddToCartRepo();
    useCase = AddCartUseCase(mockRepo);
  });

  group('AddCartUseCase Test', () {
    test(
      'should return Success<GetCartEntity> when repository success',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        final entity = GetCartEntity(
            numOfCartItems: null,
            totalPrice: null,
            totalPriceAfterDiscount: null,
            cartItems: []
          // add required fields here
        );

        when(
          mockRepo.addToCart(request),
        ).thenAnswer(
              (_) async => Success<GetCartEntity>(
            data: entity,
          ),
        );

        // Act
        final result = await useCase(request);

        // Assert
        expect(result, isA<Success<GetCartEntity>>());

        verify(mockRepo.addToCart(request)).called(1);
      },
    );

    test(
      'should return Failure<GetCartEntity> when repository fails',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        when(
          mockRepo.addToCart(request),
        ).thenAnswer(
              (_) async => Failure<GetCartEntity>(
            errorMessage: 'Server Error',
          ),
        );

        // Act
        final result = await useCase(request);

        // Assert
        expect(result, isA<Failure<GetCartEntity>>());

        final failure = result as Failure<GetCartEntity>;

        expect(failure.errorMessage, 'Server Error');

        verify(mockRepo.addToCart(request)).called(1);
      },
    );
  });
}