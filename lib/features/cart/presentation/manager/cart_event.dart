import '../../data/model/request/update_cart_request.dart';

sealed class CartEvent {}

class GetCartItemsEvent extends CartEvent {}

class UpdateCartItemEvent extends CartEvent {
  final UpdateCartRequest quantity;
  final String productId;

  UpdateCartItemEvent({required this.quantity, required this.productId});
}

class DeleteCartItemEvent extends CartEvent {
  final String productId;

  DeleteCartItemEvent({required this.productId});
}
