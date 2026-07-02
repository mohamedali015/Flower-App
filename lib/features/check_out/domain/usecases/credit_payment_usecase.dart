import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
import 'package:flower_app/features/check_out/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditPaymentUsecase {
  final CheckoutRepo _repo;

  CreditPaymentUsecase(this._repo);

  Future<Result<CreditPaymentEntity>> call(
    String token,
    CheckoutPaymentRequest request,
  ) {
    return _repo.creditcheckout(token, request);
  }
}
