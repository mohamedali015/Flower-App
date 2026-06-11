import 'package:equatable/equatable.dart';
import 'package:flower_app/features/check_out/presentation/factory/checkout_factory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/request/credit_payment_request.dart';
import '../../domain/Entities/cashorder_entity.dart';
import '../../domain/Entities/credit_payment.dart';
import '../../domain/usecases/cash_payment_usecase.dart';
import '../../domain/usecases/credit_payment_usecase.dart';
import 'checkout_intents.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutFactory _checkoutFactory;

  CheckoutCubit(this._checkoutFactory) : super(const CheckoutState());

  void doIntent(CheckoutIntent intent) {
    switch (intent) {
      case CashPaymentIntent():
        _executeCashPayment();
        break;
      case CreditPaymentIntent():
        _executeCreditPayment(intent.request);
        break;
    }
  }

  Future<void> _executeCashPayment() async {
    emit(state.copyWith(cashPaymentState: const BaseState(isLoading: true)));
    final result = await _checkoutFactory.cashPaymentUsecase().call();
    switch (result) {
      case Success():
        emit(
          state.copyWith(
            cashPaymentState: BaseState(isSuccess: true, data: result.data),
          ),
        );
        break;
      case Failure():
        emit(
          state.copyWith(
            cashPaymentState: BaseState(errorMessage: result.errorMessage),
          ),
        );
        break;
    }
  }

  Future<void> _executeCreditPayment(CheckoutPaymentRequest request) async {
    emit(state.copyWith(creditPaymentState: const BaseState(isLoading: true)));
    final result = await _checkoutFactory.creditPaymentUsecase().call(request);
    switch (result) {
      case Success():
        emit(
          state.copyWith(
            creditPaymentState: BaseState(isSuccess: true, data: result.data),
          ),
        );
        break;
      case Failure():
        emit(
          state.copyWith(
            creditPaymentState: BaseState(errorMessage: result.errorMessage),
          ),
        );
        break;
    }
  }
}
