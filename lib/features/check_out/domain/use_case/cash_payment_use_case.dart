import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../data/models/request/credit_payment_request.dart';
import '../Entities/cashorder_entity.dart';
import '../repositories/checkout_repo.dart';

@injectable
class CashPaymentUseCase {
  final CheckoutRepo _repo;
  CashPaymentUseCase(this._repo);
  Future<Result<CashOrderEntity>> call({
    required CheckoutPaymentRequest request,
  }) {
    return _repo.cashOrder(request: request);
  }
}
