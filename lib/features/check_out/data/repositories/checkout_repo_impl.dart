import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/features/check_out/data/data_source/checkout_data_source.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';
import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
import 'package:flower_app/features/check_out/domain/Entities/credit_payment.dart';
import 'package:flower_app/features/check_out/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepo)
class CheckoutRepoImpl implements CheckoutRepo {
  final CheckoutDataSource _checkoutDataSource;
  final SecureCache secureCache;

  CheckoutRepoImpl(this._checkoutDataSource, this.secureCache);

  @override
  Future<Result<CashorderEntity>> cashorder(
    String token,
    CheckoutPaymentRequest request,
  ) async {
    final response = await _checkoutDataSource.cashOrder(token, request);

    switch (response) {
      case Success<CashOrderResponse>():
        return Success(data: response.data.toEntity());
      case Failure<CashOrderResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<CreditPaymentEntity>> creditcheckout(
    String token,
    CheckoutPaymentRequest request,
  ) async {
    final response = await _checkoutDataSource.creditCheckout(token, request);

    switch (response) {
      case Success<CreditPaymentResponse>():
        return Success(data: response.data.toEntity());
      case Failure<CreditPaymentResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
