import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';

abstract interface class CheckoutRepo {
  Future<Result<CashorderEntity>> cashorder();
  Future<Result<CreditPaymentEntity>> creditcheckout(
    CheckoutPaymentRequest request,
  );
}
