import 'package:equatable/equatable.dart';
import '../data/model/request/add_to_cart_request.dart';
import '../data/model/request/update_cart_request.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCartItemsEvent extends CartEvent {}

class UpdateCartItemEvent extends CartEvent {
  final UpdateCartRequest quantity;
  final String productId;
  UpdateCartItemEvent({required this.quantity, required this.productId});
  @override
  List<Object?> get props => [quantity, productId];
}

class DeleteCartItemEvent extends CartEvent {
  final String productId;

  DeleteCartItemEvent({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class AddToCart extends CartEvent {
  final AddToCartRequest addToCartRequest;
  AddToCart(this.addToCartRequest);

  @override
  List<Object> get props => [addToCartRequest];
}

class DeleteAll extends CartEvent{}
