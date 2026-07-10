import 'package:injectable/injectable.dart';
import '../entities/track_order_entity.dart';
import '../repositories/track_order_repo.dart';

@injectable
class GetTrackOrderUseCase {
  final TrackOrderRepo _repo;

  GetTrackOrderUseCase(this._repo);

  Stream<TrackOrderEntity> call(String orderId) {
    return _repo.watchOrder(orderId);
  }
}
