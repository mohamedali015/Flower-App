import 'package:flower_app/config/add_to_cart/api/add_to_cart_api_client.dart';
import 'package:flower_app/config/add_to_cart/api/data_source/add_to_cart_data_source_impl.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_to_cart_data_source_impl_test.mocks.dart';

@GenerateMocks([AddToCartApiClient])
void main() {
  late AddToCartDataSourceImpl dataSource;
  late MockAddToCartApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockAddToCartApiClient();
    dataSource = AddToCartDataSourceImpl(mockApiClient);
  });

  group('AddToCartDataSourceImpl Test', () {
    test(
      'should return Success<CartResponse> when api call success',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        final response = CartResponse(
          message: "Product added successfully",
        );

        when(
          mockApiClient.addToCart(request),
        ).thenAnswer((_) async => response);

        // Act
        final result = await dataSource.addToCart(request);

        // Assert
        expect(result, isA<Success<CartResponse>>());

        final success = result as Success<CartResponse>;

        expect(success.data.message, response.message);

        verify(mockApiClient.addToCart(request)).called(1);
      },
    );

    test(
      'should return Failure<CartResponse> when api throws exception',
          () async {
        // Arrange
        final request = AddToCartRequest(
          product: "1",
          quantity: 2,
        );

        when(
          mockApiClient.addToCart(request),
        ).thenThrow(Exception('Server Error'));

        // Act
        final result = await dataSource.addToCart(request);

        // Assert
        expect(result, isA<Failure<CartResponse>>());

        verify(mockApiClient.addToCart(request)).called(1);
      },
    );
  });
}