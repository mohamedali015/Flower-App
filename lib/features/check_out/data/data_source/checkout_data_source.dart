import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';

abstract interface class CheckoutDataSource {
  Future<Result<CashOrderResponse>> cashOrder(
    String token,
    CheckoutPaymentRequest request,
  );
  Future<Result<CreditPaymentResponse>> creditCheckout(
    String token,
    CheckoutPaymentRequest request,
  );
}
