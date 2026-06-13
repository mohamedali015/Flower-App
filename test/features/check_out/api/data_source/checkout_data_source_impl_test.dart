import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/api/checkout_api_client.dart';
import 'package:flower_app/features/check_out/api/data_source/checkout_data_source_impl.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckoutApiClient])
void main() {
  late MockCheckoutApiClient mockCheckoutApiClient;
  late CheckoutDataSourceImpl dataSource;

  setUp(() {
    mockCheckoutApiClient = MockCheckoutApiClient();
    dataSource = CheckoutDataSourceImpl(mockCheckoutApiClient);
  });

  group('CheckoutDataSourceImpl - cashOrder', () {
    const token = 'fake_token';

    test('should return Success<CashOrderResponse> when API call is successful', () async {
      // Arrange
      final mockResponse = CashOrderResponse(
        message: 'Order placed successfully',
      );

      when(mockCheckoutApiClient.cashOrder(any))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.cashOrder(token);

      // Assert
      expect(result, isA<Success<CashOrderResponse>>());
      expect((result as Success<CashOrderResponse>).data, mockResponse);
      verify(mockCheckoutApiClient.cashOrder(token)).called(1);
    });

    test('should return Failure<CashOrderResponse> when API throws exception', () async {
      // Arrange
      when(mockCheckoutApiClient.cashOrder(any))
          .thenThrow(Exception('API error'));

      // Act
      final result = await dataSource.cashOrder(token);

      // Assert
      expect(result, isA<Failure<CashOrderResponse>>());
      expect((result as Failure<CashOrderResponse>).errorMessage, isNotNull);
      verify(mockCheckoutApiClient.cashOrder(token)).called(1);
    });
  });

  group('CheckoutDataSourceImpl - creditCheckout', () {
    const token = 'fake_token';
    final request = CheckoutPaymentRequest(
      shippingAddress: ShippingAddress(
        street: '123 Street',
        phone: '123456789',
        city: 'Cairo',
        lat: '30.0',
        long: '31.0',
      ),
    );

    test('should return Success<CreditPaymentResponse> when API call is successful', () async {
      // Arrange
      final mockResponse = CreditPaymentResponse(
        message: 'Payment session created',
      );

      when(mockCheckoutApiClient.creditCheckout(any, any))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.creditCheckout(token, request);

      // Assert
      expect(result, isA<Success<CreditPaymentResponse>>());
      expect((result as Success<CreditPaymentResponse>).data, mockResponse);
      verify(mockCheckoutApiClient.creditCheckout(token, request)).called(1);
    });

    test('should return Failure<CreditPaymentResponse> when API throws exception', () async {
      // Arrange
      when(mockCheckoutApiClient.creditCheckout(any, any))
          .thenThrow(Exception('API error'));

      // Act
      final result = await dataSource.creditCheckout(token, request);

      // Assert
      expect(result, isA<Failure<CreditPaymentResponse>>());
      expect((result as Failure<CreditPaymentResponse>).errorMessage, isNotNull);
      verify(mockCheckoutApiClient.creditCheckout(token, request)).called(1);
    });
  });
}