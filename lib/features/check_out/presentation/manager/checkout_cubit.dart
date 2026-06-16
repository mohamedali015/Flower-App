import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/request/credit_payment_request.dart';
import '../../domain/Entities/cashorder_entity.dart';
import '../../domain/Entities/credit_payment.dart';
import '../../domain/use_case/cash_payment_use_case.dart';
import '../../domain/use_case/credit_payment_use_case.dart';
import 'checkout_intents.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CashPaymentUseCase _cashPaymentUseCase;
  final CreditPaymentUseCase _creditPaymentUseCase;
  CheckoutCubit(this._creditPaymentUseCase,this._cashPaymentUseCase)
    : super(const CheckoutState());

  void doIntent(CheckoutIntent intent) {
    switch (intent) {
      case CashPaymentIntent():
        _executeCashPayment(intent.request);
        break;
      case CreditPaymentIntent():
        _executeCreditPayment(request: intent.request,url: intent.url);
        break;
    }
  }

  Future<void> _executeCashPayment(CheckoutPaymentRequest request) async {
    emit(state.copyWith(cashPaymentState: const BaseState(isLoading: true)));
    final result = await _cashPaymentUseCase.call(request:request );
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

  Future<void> _executeCreditPayment({required CheckoutPaymentRequest request,required String url}) async {
    emit(state.copyWith(creditPaymentState: const BaseState(isLoading: true)));
    final result = await _creditPaymentUseCase.call(
      url: url,
      request: request
    );
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
