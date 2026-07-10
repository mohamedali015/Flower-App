import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/data/data_sources/remote/track_order_remote_data_source.dart';
import 'package:flower_app/features/track_order/data/mapper/open_route_mapper.dart';
import 'package:flower_app/features/track_order/data/mapper/track_order_mapper.dart';
import 'package:flower_app/features/track_order/data/models/remote/open_route_response.dart';
import 'package:flower_app/features/track_order/domain/entities/route_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower_app/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderRemoteDataSource _remoteDataSource;

  TrackOrderRepoImpl(this._remoteDataSource);

  @override
  Stream<TrackOrderEntity> watchOrder(String orderId) {
    return _remoteDataSource
        .watchOrder(orderId)
        .map((response) => response.toEntity());
  }

  @override
  Future<Result<RouteEntity>> getRoute({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) async {
    final result = await _remoteDataSource.getRoute(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );

    switch (result) {
      case Success<OpenRouteResponse>():
        return Success(data: result.data.toEntity());
      case Failure<OpenRouteResponse>():
        return Failure(errorMessage: result.errorMessage);
    }
  }

  @override
  Future<Result<void>> updateOrderToCompleted(String orderId) {
    return _remoteDataSource.updateOrderToCompleted(orderId);
  }
}
