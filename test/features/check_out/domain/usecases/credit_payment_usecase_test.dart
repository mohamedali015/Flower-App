// import 'package:flower_app/config/error_handling/result.dart';
// import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
// import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
// import 'package:flower_app/features/check_out/domain/repositories/checkout_repo.dart';
// import 'package:flower_app/features/check_out/domain/usecases/credit_payment_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'credit_payment_usecase_test.mocks.dart';
//
// @GenerateMocks([CheckoutRepo])
// void main() {
//   late MockCheckoutRepo mockRepo;
//   late CreditPaymentUsecase usecase;
//
//   setUpAll(() {
//     provideDummy<Result<CreditPaymentEntity>>(
//       Success<CreditPaymentEntity>(data: const CreditPaymentEntity()),
//     );
//     provideDummy<Result<CreditPaymentEntity>>(
//       Failure<CreditPaymentEntity>(errorMessage: 'dummy'),
//     );
//   });
//
//   setUp(() {
//     mockRepo = MockCheckoutRepo();
//     usecase = CreditPaymentUsecase(mockRepo);
//   });
//
//   group('CreditPaymentUsecase', () {
//     const token = 'fake_token';
//     final request = CheckoutPaymentRequest(
//       shippingAddress: ShippingAddress(
//         street: '123 Street',
//         phone: '123456789',
//         city: 'Cairo',
//         lat: '30.0',
//         long: '31.0',
//       ),
//     );
//
//     test('should return Success<CreditPaymentEntity> when repo succeeds', () async {
//       // Arrange
//       const expectedEntity = CreditPaymentEntity(message: 'Success');
//       when(mockRepo.creditcheckout(any, any))
//           .thenAnswer((_) async => Success<CreditPaymentEntity>(data: expectedEntity));
//
//       // Act
//       final result = await usecase.call(token, request);
//
//       // Assert
//       expect(result, isA<Success<CreditPaymentEntity>>());
//       expect((result as Success<CreditPaymentEntity>).data, expectedEntity);
//       verify(mockRepo.creditcheckout(token, request)).called(1);
//     });
//
//     test('should return Failure<CreditPaymentEntity> when repo fails', () async {
//       // Arrange
//       when(mockRepo.creditcheckout(any, any))
//           .thenAnswer((_) async => Failure<CreditPaymentEntity>(errorMessage: 'Error'));
//
//       // Act
//       final result = await usecase.call(token, request);
//
//       // Assert
//       expect(result, isA<Failure<CreditPaymentEntity>>());
//       expect((result as Failure<CreditPaymentEntity>).errorMessage, 'Error');
//       verify(mockRepo.creditcheckout(token, request)).called(1);
//     });
//   });
// }
