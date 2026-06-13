import 'package:flower_app/features/check_out/domain/usecases/cash_payment_usecase.dart';
import 'package:flower_app/features/check_out/domain/usecases/credit_payment_usecase.dart';

abstract class CheckoutFactory {
  CashPaymentUsecase cashPaymentUsecase();
  CreditPaymentUsecase creditPaymentUsecase();
}
