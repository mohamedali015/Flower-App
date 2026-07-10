import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class RemoveCartUseCase {
  final CartRepo _cartRepo;
  RemoveCartUseCase(this._cartRepo);

  Future<Result<GetCartEntity>> call(String id) {
    return _cartRepo.removeFromCart(id);
  }
}
