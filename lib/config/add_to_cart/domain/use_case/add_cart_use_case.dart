import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../../../features/cart/domain/entities/get_cart_entity.dart';
import '../repositories/add_to_cart_repo.dart';

@injectable
class AddCartUseCase {
  final AddToCartRepo _addCart;
  AddCartUseCase(this._addCart);
  Future<Result<GetCartEntity>> call(AddToCartRequest request) {
    return _addCart.addToCart(request);
  }
}
