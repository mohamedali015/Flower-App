import 'package:flower_app/config/error_handling/result.dart';
import '../../data/model/request/update_cart_request.dart';
import '../entities/get_cart_entity.dart';

abstract class CartRepo {
  Future<Result<GetCartEntity>> getCart();
  Future<Result<GetCartEntity>> removeFromCart(String id);
  Future<Result<GetCartEntity>> updateCart(UpdateCartRequest quantity,String id);
}
