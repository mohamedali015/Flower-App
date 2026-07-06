import 'package:flower_app/features/check_out/domain/usecases/cash_payment_usecase.dart';
import 'package:flower_app/features/check_out/domain/usecases/credit_payment_usecase.dart';
import 'package:flower_app/features/check_out/presentation/factory/checkout_factory.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutFactory)
class CheckoutFactoryImpl implements CheckoutFactory {
  final CashPaymentUsecase _cashPaymentUsecase;
  final CreditPaymentUsecase _creditPaymentUsecase;
  CheckoutFactoryImpl(this._cashPaymentUsecase, this._creditPaymentUsecase);
  @override
  CashPaymentUsecase cashPaymentUsecase() {
    return _cashPaymentUsecase;
  }

  @override
  CreditPaymentUsecase creditPaymentUsecase() {
    return _creditPaymentUsecase;
  }
}
