import 'package:dio/dio.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';
import 'package:flower_app/features/check_out/data/models/response/cash_order_response.dart';
import 'package:flower_app/features/check_out/data/models/response/credit_payment_response.dart';
import 'package:injectable/injectable.dart';

import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';

part 'checkout_api_client.g.dart';

@injectable
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @POST(ApiEndPoints.getOrders)
  Future<CashOrderResponse> cashOrder(
      @Body() CheckoutPaymentRequest? request,
      );


  @POST(ApiEndPoints.creditCheckout)
  Future<CreditPaymentResponse> creditCheckout(
    @Body() CheckoutPaymentRequest? request,
      @Query('url') String url,
  );
}
