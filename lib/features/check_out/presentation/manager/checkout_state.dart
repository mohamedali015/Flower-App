part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final BaseState<CashorderEntity> cashPaymentState;
  final BaseState<CreditPaymentEntity> creditPaymentState;

  const CheckoutState({
    this.cashPaymentState = const BaseState(),
    this.creditPaymentState = const BaseState(),
  });

  CheckoutState copyWith({
    BaseState<CashorderEntity>? cashPaymentState,
    BaseState<CreditPaymentEntity>? creditPaymentState,
  }) {
    return CheckoutState(
      cashPaymentState: cashPaymentState ?? this.cashPaymentState,
      creditPaymentState: creditPaymentState ?? this.creditPaymentState,
    );
  }

  @override
  List<Object?> get props => [cashPaymentState, creditPaymentState];
}
