import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';

sealed class CheckoutIntent {}

class CashPaymentIntent extends CheckoutIntent {
  final CheckoutPaymentRequest request;

  CashPaymentIntent(this.request);
}

class CreditPaymentIntent extends CheckoutIntent {
  final CheckoutPaymentRequest request;

  CreditPaymentIntent(this.request);
}

class PlaceOrderIntent extends CheckoutIntent {}
