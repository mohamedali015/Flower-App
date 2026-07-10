import 'package:equatable/equatable.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/check_out/presentation/factory/checkout_factory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/request/credit_payment_request.dart';
import '../../domain/Entities/cashorder_entity.dart';
import '../../domain/Entities/credit_payment.dart';
import 'checkout_intents.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutFactory _checkoutFactory;
  final SecureCache _secureCache;

  CheckoutCubit(this._checkoutFactory, this._secureCache)
    : super(const CheckoutState());

  void doIntent(CheckoutIntent intent) {
    switch (intent) {
      case CashPaymentIntent():
        _executeCashPayment(intent.request);
        break;
      case CreditPaymentIntent():
        _executeCreditPayment(intent.request);
        break;
      case PlaceOrderIntent():
        _executePlaceOrder();
        break;
    }
  }

  Future<void> _executeCashPayment(CheckoutPaymentRequest request) async {
    final token = await _secureCache.getData(key: 'token');
    emit(state.copyWith(cashPaymentState: const BaseState(isLoading: true)));
    final result = await _checkoutFactory.cashPaymentUsecase().call(
      token!,
      request,
    );
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
    final token = await _secureCache.getData(key: 'token');
    emit(state.copyWith(creditPaymentState: const BaseState(isLoading: true)));
    final result = await _checkoutFactory.creditPaymentUsecase().call(
      token!,
      request,
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

  void _executePlaceOrder() {}
}
