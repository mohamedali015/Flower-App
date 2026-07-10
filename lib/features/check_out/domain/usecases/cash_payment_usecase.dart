import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
import 'package:flower_app/features/check_out/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CashPaymentUsecase {
  final CheckoutRepo _repo;

  CashPaymentUsecase(this._repo);

  Future<Result<CashorderEntity>> call(
    String token,
    CheckoutPaymentRequest request,
  ) {
    return _repo.cashorder(token, request);
  }
}
