import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../repositories/track_order_repo.dart';

@injectable
class UpdateOrderToCompletedUseCase {
  final TrackOrderRepo _repo;

  UpdateOrderToCompletedUseCase(this._repo);

  Future<Result<void>> call(String orderId) {
    return _repo.updateOrderToCompleted(orderId);
  }
}
