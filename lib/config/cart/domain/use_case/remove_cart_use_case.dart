import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class  RemoveCartUseCase{
  final CartRepo _removeCart;
  RemoveCartUseCase(this._removeCart);

  Future<Result<GetCartEntity>> call(String id) {
    return _removeCart.removeFromCart(id);
  }
}
