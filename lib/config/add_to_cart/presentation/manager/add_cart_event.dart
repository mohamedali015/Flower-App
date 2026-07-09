import 'package:equatable/equatable.dart';
import '../../../../features/cart/data/model/request/add_to_cart_request.dart';

sealed class AddCartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends AddCartEvent {
  final AddToCartRequest addToCartRequest;
  AddToCart(this.addToCartRequest);

  @override
  List<Object> get props => [addToCartRequest];
}
