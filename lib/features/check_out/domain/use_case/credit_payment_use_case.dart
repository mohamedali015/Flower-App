import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/models/request/credit_payment_request.dart';
import '../Entities/credit_payment.dart';
import '../repositories/checkout_repo.dart';

@injectable
class CreditPaymentUseCase {
  final CheckoutRepo _repo;

  CreditPaymentUseCase(this._repo);

  Future<Result<CreditPaymentEntity>> call({
    required String url,
    required CheckoutPaymentRequest request,
  }) {
    return _repo.creditCheckout(url: url, request: request);
  }
}
