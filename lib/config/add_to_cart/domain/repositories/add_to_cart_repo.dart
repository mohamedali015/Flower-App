import '../../../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../../../features/cart/domain/entities/get_cart_entity.dart';
import '../../../error_handling/result.dart';

abstract class AddToCartRepo {
  Future<Result<GetCartEntity>> addToCart(AddToCartRequest request);
}
