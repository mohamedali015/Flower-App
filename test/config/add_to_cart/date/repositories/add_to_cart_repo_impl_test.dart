import 'package:flower_app/config/add_to_cart/date/data_source/add_to_cart_data_source.dart';
import 'package:flower_app/config/add_to_cart/date/repositories/add_to_cart_repo_impl.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_to_cart_repo_impl_test.mocks.dart';

@GenerateMocks([AddToCartDataSource])
void main() {
  late MockAddToCartDataSource mockDataSource;
  late AddToCartRepoImpl repoImpl;

  setUpAll(() {
    provideDummy<Result<CartResponse>>(
      Failure<CartResponse>(
        errorMessage: 'dummy',
      ),
    );
  });

  setUp(() {
    mockDataSource = MockAddToCartDataSource();
    repoImpl = AddToCartRepoImpl(mockDataSource);
  });

  group('AddToCartRepoImpl Test', () {
    test(
      'should return Success<GetCartEntity> when datasource success',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        final response = CartResponse.fromJson({
          "status": "success",
          "message": "added",
          "numOfCartItems": 1,
          "cartId": "123",
          "data": {
            "_id": "1",
            "cartOwner": "owner",
            "products": [],
            "createdAt": "",
            "updatedAt": "",
            "__v": 0,
            "totalCartPrice": 100
          }
        });

        when(
          mockDataSource.addToCart(request),
        ).thenAnswer(
              (_) async => Success<CartResponse>(
            data: response,
          ),
        );

        // Act
        final result = await repoImpl.addToCart(request);

        // Assert
        expect(result, isA<Success<GetCartEntity>>());

        verify(mockDataSource.addToCart(request)).called(1);
      },
    );

    test(
      'should return Failure<GetCartEntity> when datasource fails',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        when(
          mockDataSource.addToCart(request),
        ).thenAnswer(
              (_) async => Failure<CartResponse>(
            errorMessage: 'Server Error',
          ),
        );

        // Act
        final result = await repoImpl.addToCart(request);

        // Assert
        expect(result, isA<Failure<GetCartEntity>>());

        final failure = result as Failure<GetCartEntity>;

        expect(failure.errorMessage, 'Server Error');

        verify(mockDataSource.addToCart(request)).called(1);
      },
    );
  });
}