import 'package:injectable/injectable.dart';
import '../../../error_handling/result.dart';
import '../../data/model/request/add_to_cart_request.dart';
import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class AddCartUseCase {
  final CartRepo _addCart;
  AddCartUseCase(this._addCart);
  Future<Result<GetCartEntity>> call(AddToCartRequest request) {
    return _addCart.addToCart(request);
  }
}
