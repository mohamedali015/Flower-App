import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/check_out/api/checkout_api_client.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';
import 'package:flower_app/features/check_out/data/data_source/checkout_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutDataSource)
class CheckoutDataSourceImpl implements CheckoutDataSource {
  final CheckoutApiClient _checkoutApiClient;

  CheckoutDataSourceImpl(this._checkoutApiClient);

  @override
  Future<Result<CashOrderResponse>> cashOrder({required CheckoutPaymentRequest request}) {
    return executeApi(() async {
      return _checkoutApiClient.cashOrder(request);
    });
  }

  @override
  Future<Result<CreditPaymentResponse>> creditCheckout(
      {required String url,required CheckoutPaymentRequest request,}
  ) {
    return executeApi(() async {
      return _checkoutApiClient.creditCheckout(url, request);
    });
  }
}
