import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/result.dart';
import '../entities/route_entity.dart';
import '../repositories/track_order_repo.dart';

@injectable
class GetRouteUseCase {
  final TrackOrderRepo _repo;

  GetRouteUseCase(this._repo);

  Future<Result<RouteEntity>> call({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    return _repo.getRoute(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );
  }
}
