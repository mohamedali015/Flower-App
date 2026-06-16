import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/check_out/data/data_source/checkout_data_source.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';
import 'package:flower_app/features/check_out/data/repositories/checkout_repo_impl.dart';
import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_repo_impl_test.mocks.dart';

@GenerateMocks([CheckoutDataSource, SecureCache])
void main() {
  late MockCheckoutDataSource mockDataSource;
  late MockSecureCache mockSecureCache;
  late CheckoutRepoImpl repo;

  setUpAll(() {
    provideDummy<Result<CashOrderResponse>>(
      Success<CashOrderResponse>(data: CashOrderResponse(message: 'dummy')),
    );
    provideDummy<Result<CashOrderResponse>>(
      Failure<CashOrderResponse>(errorMessage: 'dummy'),
    );
    provideDummy<Result<CreditPaymentResponse>>(
      Success<CreditPaymentResponse>(data: CreditPaymentResponse(message: 'dummy')),
    );
    provideDummy<Result<CreditPaymentResponse>>(
      Failure<CreditPaymentResponse>(errorMessage: 'dummy'),
    );
  });

  setUp(() {
    mockDataSource = MockCheckoutDataSource();
    mockSecureCache = MockSecureCache();
    repo = CheckoutRepoImpl(mockDataSource, mockSecureCache);
  });

  group('CheckoutRepoImpl - cashorder', () {
    const token = 'fake_token';

    test('should return Success<CashorderEntity> when data source succeeds', () async {
      // Arrange
      final response = CashOrderResponse(message: 'Success');
      when(mockDataSource.cashOrder(any))
          .thenAnswer((_) async => Success<CashOrderResponse>(data: response));

      // Act
      final result = await repo.cashorder(token);

      // Assert
      expect(result, isA<Success<CashOrderEntity>>());
      expect((result as Success<CashOrderEntity>).data, const CashOrderEntity());
      verify(mockDataSource.cashOrder(token)).called(1);
    });

    test('should return Failure<CashorderEntity> when data source fails', () async {
      // Arrange
      when(mockDataSource.cashOrder(any))
          .thenAnswer((_) async => Failure<CashOrderResponse>(errorMessage: 'Error'));

      // Act
      final result = await repo.cashorder(token);

      // Assert
      expect(result, isA<Failure<CashOrderEntity>>());
      expect((result as Failure<CashOrderEntity>).errorMessage, 'Error');
      verify(mockDataSource.cashOrder(token)).called(1);
    });
  });

  group('CheckoutRepoImpl - creditcheckout', () {
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

    test('should return Success<CreditPaymentEntity> when data source succeeds', () async {
      // Arrange
      final response = CreditPaymentResponse(message: 'Success');
      when(mockDataSource.creditCheckout(any, any))
          .thenAnswer((_) async => Success<CreditPaymentResponse>(data: response));

      // Act
      final result = await repo.creditcheckout(token, request);

      // Assert
      expect(result, isA<Success<CreditPaymentEntity>>());
      expect((result as Success<CreditPaymentEntity>).data, const CreditPaymentEntity());
      verify(mockDataSource.creditCheckout(token, request)).called(1);
    });

    test('should return Failure<CreditPaymentEntity> when data source fails', () async {
      // Arrange
      when(mockDataSource.creditCheckout(any, any))
          .thenAnswer((_) async => Failure<CreditPaymentResponse>(errorMessage: 'Error'));

      // Act
      final result = await repo.creditcheckout(token, request);

      // Assert
      expect(result, isA<Failure<CreditPaymentEntity>>());
      expect((result as Failure<CreditPaymentEntity>).errorMessage, 'Error');
      verify(mockDataSource.creditCheckout(token, request)).called(1);
    });
  });
}
