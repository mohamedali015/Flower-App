// import 'package:flower_app/config/error_handling/result.dart';
// import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
// import 'package:flower_app/features/check_out/domain/repositories/checkout_repo.dart';
// import 'package:flower_app/features/check_out/domain/usecases/cash_payment_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'cash_payment_usecase_test.mocks.dart';
//
// @GenerateMocks([CheckoutRepo])
// void main() {
//   late MockCheckoutRepo mockRepo;
//   late CashPaymentUsecase usecase;
//
//   setUpAll(() {
//     provideDummy<Result<CashOrderEntity>>(
//       Success<CashOrderEntity>(data: const CashOrderEntity()),
//     );
//     provideDummy<Result<CashOrderEntity>>(
//       Failure<CashOrderEntity>(errorMessage: 'dummy'),
//     );
//   });
//
//   setUp(() {
//     mockRepo = MockCheckoutRepo();
//     usecase = CashPaymentUsecase(mockRepo);
//   });
//
//   group('CashPaymentUsecase', () {
//     const token = 'fake_token';
//
//     test('should return Success<CashorderEntity> when repo succeeds', () async {
//       // Arrange
//       const expectedEntity = CashOrderEntity(message: 'Success');
//       when(mockRepo.cashorder(any))
//           .thenAnswer((_) async => Success<CashOrderEntity>(data: expectedEntity));
//
//       // Act
//       final result = await usecase.call(token);
//
//       // Assert
//       expect(result, isA<Success<CashOrderEntity>>());
//       expect((result as Success<CashOrderEntity>).data, expectedEntity);
//       verify(mockRepo.cashorder(token)).called(1);
//     });
//
//     test('should return Failure<CashorderEntity> when repo fails', () async {
//       // Arrange
//       when(mockRepo.cashorder(any))
//           .thenAnswer((_) async => Failure<CashOrderEntity>(errorMessage: 'Error'));
//
//       // Act
//       final result = await usecase.call(token);
//
//       // Assert
//       expect(result, isA<Failure<CashOrderEntity>>());
//       expect((result as Failure<CashOrderEntity>).errorMessage, 'Error');
//       verify(mockRepo.cashorder(token)).called(1);
//     });
//   });
// }
