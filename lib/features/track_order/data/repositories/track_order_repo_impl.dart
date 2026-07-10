import 'package:injectable/injectable.dart';

import '../../domain/entities/track_order_entity.dart';
import '../../domain/repositories/track_order_repo.dart';
import '../data_sources/remote/track_order_remote_data_source.dart';
import '../mapper/track_order_mapper.dart';

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
}
