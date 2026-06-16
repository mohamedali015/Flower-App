import 'package:equatable/equatable.dart';
import 'package:flower_app/features/check_out/data/models/request/credit_payment_request.dart';

sealed class CheckoutIntent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CashPaymentIntent extends CheckoutIntent {
  final CheckoutPaymentRequest request;
  CashPaymentIntent(this.request);
  @override
  List<Object?> get props => [request];
}

class CreditPaymentIntent extends CheckoutIntent {
  final CheckoutPaymentRequest request;
  final String url;
  CreditPaymentIntent({required this.request,required this.url});
  @override
  List<Object?> get props => [request,url];
}

