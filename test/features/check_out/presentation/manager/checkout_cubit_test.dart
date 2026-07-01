// import 'package:flower_app/config/base_state/base_state.dart';
// import 'package:flower_app/config/error_handling/result.dart';
// import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
// import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
// import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
// import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
// import 'package:flower_app/features/check_out/domain/usecases/cash_payment_usecase.dart';
// import 'package:flower_app/features/check_out/domain/usecases/credit_payment_usecase.dart';
// import 'package:flower_app/features/check_out/presentation/factory/checkout_factory.dart';
// import 'package:flower_app/features/check_out/presentation/manager/checkout_cubit.dart';
// import 'package:flower_app/features/check_out/presentation/manager/checkout_intents.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'checkout_cubit_test.mocks.dart';
//
// @GenerateMocks([CheckoutFactory, SecureCache, CashPaymentUsecase, CreditPaymentUsecase])
// void main() {
//   late MockCheckoutFactory mockCheckoutFactory;
//   late MockSecureCache mockSecureCache;
//   late MockCashPaymentUsecase mockCashPaymentUsecase;
//   late MockCreditPaymentUsecase mockCreditPaymentUsecase;
//   late CheckoutCubit cubit;
//
//   setUpAll(() {
//     provideDummy<Result<CashOrderEntity>>(
//       Success<CashOrderEntity>(data: const CashOrderEntity()),
//     );
//     provideDummy<Result<CashOrderEntity>>(
//       Failure<CashOrderEntity>(errorMessage: 'dummy'),
//     );
//     provideDummy<Result<CreditPaymentEntity>>(
//       Success<CreditPaymentEntity>(data: const CreditPaymentEntity()),
//     );
//     provideDummy<Result<CreditPaymentEntity>>(
//       Failure<CreditPaymentEntity>(errorMessage: 'dummy'),
//     );
//   });
//
//   setUp(() {
//     mockCheckoutFactory = MockCheckoutFactory();
//     mockSecureCache = MockSecureCache();
//     mockCashPaymentUsecase = MockCashPaymentUsecase();
//     mockCreditPaymentUsecase = MockCreditPaymentUsecase();
//
//     when(mockCheckoutFactory.cashPaymentUsecase())
//         .thenReturn(mockCashPaymentUsecase);
//     when(mockCheckoutFactory.creditPaymentUsecase())
//         .thenReturn(mockCreditPaymentUsecase);
//
//     cubit = CheckoutCubit(mockCheckoutFactory, mockSecureCache);
//   });
//
//   tearDown(() async {
//     await cubit.close();
//   });
//
//   group('CheckoutCubit - CashPaymentIntent', () {
//     const token = 'fake_token';
//
//     test('emits loading and success states when cash payment succeeds', () async {
//       // Arrange
//       const expectedEntity = CashOrderEntity(message: 'Success');
//       when(mockSecureCache.getData(key: 'token'))
//           .thenAnswer((_) async => token);
//       when(mockCashPaymentUsecase.call(any))
//           .thenAnswer((_) async => Success<CashOrderEntity>(data: expectedEntity));
//
//       // Assert expected states in order
//       expectLater(
//         cubit.stream,
//         emitsInOrder([
//           const CheckoutState(cashPaymentState: BaseState(isLoading: true)),
//           const CheckoutState(
//             cashPaymentState: BaseState(isSuccess: true, data: expectedEntity),
//           ),
//         ]),
//       );
//
//       // Act
//       cubit.doIntent(CashPaymentIntent());
//
//       // Verify dependencies were called
//       await untilCalled(mockSecureCache.getData(key: 'token'));
//       verify(mockSecureCache.getData(key: 'token')).called(1);
//       verify(mockCashPaymentUsecase.call(token)).called(1);
//     });
//
//     test('emits loading and failure states when cash payment fails', () async {
//       // Arrange
//       when(mockSecureCache.getData(key: 'token'))
//           .thenAnswer((_) async => token);
//       when(mockCashPaymentUsecase.call(any))
//           .thenAnswer((_) async => Failure<CashOrderEntity>(errorMessage: 'Error'));
//
//       // Assert expected states in order
//       expectLater(
//         cubit.stream,
//         emitsInOrder([
//           const CheckoutState(cashPaymentState: BaseState(isLoading: true)),
//           const CheckoutState(
//             cashPaymentState: BaseState(errorMessage: 'Error'),
//           ),
//         ]),
//       );
//
//       // Act
//       cubit.doIntent(CashPaymentIntent());
//
//       // Verify dependencies were called
//       await untilCalled(mockSecureCache.getData(key: 'token'));
//       verify(mockSecureCache.getData(key: 'token')).called(1);
//       verify(mockCashPaymentUsecase.call(token)).called(1);
//     });
//   });
//
//   group('CheckoutCubit - CreditPaymentIntent', () {
//     const token = 'fake_token';
//     final request = CheckoutPaymentRequest(
//       shippingAddress: ShippingAddress(
//         street: '123 Street',
//         phone: '123456789',
//         city: 'Cairo',
//       ),
//     );
//
//     test('emits loading and success states when credit payment succeeds', () async {
//       // Arrange
//       const expectedEntity = CreditPaymentEntity(message: 'Success');
//       when(mockSecureCache.getData(key: 'token'))
//           .thenAnswer((_) async => token);
//       when(mockCreditPaymentUsecase.call(any, any))
//           .thenAnswer((_) async => Success<CreditPaymentEntity>(data: expectedEntity));
//
//       // Assert expected states in order
//       expectLater(
//         cubit.stream,
//         emitsInOrder([
//           const CheckoutState(creditPaymentState: BaseState(isLoading: true)),
//           const CheckoutState(
//             creditPaymentState: BaseState(isSuccess: true, data: expectedEntity),
//           ),
//         ]),
//       );
//
//       // Act
//       cubit.doIntent(CreditPaymentIntent(request));
//
//       // Verify dependencies were called
//       await untilCalled(mockSecureCache.getData(key: 'token'));
//       verify(mockSecureCache.getData(key: 'token')).called(1);
//       verify(mockCreditPaymentUsecase.call(token, request)).called(1);
//     });
//
//     test('emits loading and failure states when credit payment fails', () async {
//       // Arrange
//       when(mockSecureCache.getData(key: 'token'))
//           .thenAnswer((_) async => token);
//       when(mockCreditPaymentUsecase.call(any, any))
//           .thenAnswer((_) async => Failure<CreditPaymentEntity>(errorMessage: 'Error'));
//
//       // Assert expected states in order
//       expectLater(
//         cubit.stream,
//         emitsInOrder([
//           const CheckoutState(creditPaymentState: BaseState(isLoading: true)),
//           const CheckoutState(
//             creditPaymentState: BaseState(errorMessage: 'Error'),
//           ),
//         ]),
//       );
//
//       // Act
//       cubit.doIntent(CreditPaymentIntent(request));
//
//       // Verify dependencies were called
//       await untilCalled(mockSecureCache.getData(key: 'token'));
//       verify(mockSecureCache.getData(key: 'token')).called(1);
//       verify(mockCreditPaymentUsecase.call(token, request)).called(1);
//     });
//   });
//
//   group('CheckoutCubit - PlaceOrderIntent', () {
//     test('does not throw and keeps initial state when PlaceOrderIntent is triggered', () {
//       // Act & Assert
//       expect(() => cubit.doIntent(PlaceOrderIntent()), returnsNormally);
//       expect(cubit.state, const CheckoutState());
//     });
//   });
// }
