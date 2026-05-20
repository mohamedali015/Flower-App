import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../data/model/request/update_cart_request.dart';
import '../entities/get_cart_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class UpdateCartUseCase {
  final CartRepo _repo;
  UpdateCartUseCase(this._repo);

  Future<Result<GetCartEntity>> call(UpdateCartRequest quantity,String id) async {
    return await _repo.updateCart(quantity,id);
  }

}