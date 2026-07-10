import 'package:flower_app/config/error_handling/result.dart';
import 'package:injectable/injectable.dart';

import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class RemoveAllCartUseCase {
  final CartRepo _cartRepo;
  RemoveAllCartUseCase(this._cartRepo);
  Future<Result<GetCartEntity>> call() {
    return _cartRepo.deleteAllCart();
  }
}
