import 'package:equatable/equatable.dart';
import '../../data/model/request/add_to_cart_request.dart';
import '../../data/model/request/update_cart_request.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllCartEvent extends CartEvent {}

class RemoveToCart extends CartEvent {
  final String id;
  RemoveToCart(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateCart extends CartEvent {
  final UpdateCartRequest quantity;
  final String id;
  UpdateCart(this.quantity,this.id);
}
