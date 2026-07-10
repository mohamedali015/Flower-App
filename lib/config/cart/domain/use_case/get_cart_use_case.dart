import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class GetCartUseCase {
  final CartRepo _cartRepo;
  GetCartUseCase(this._cartRepo);
  Future<Result<GetCartEntity>> call() {
    return _cartRepo.getCart();
  }
}
