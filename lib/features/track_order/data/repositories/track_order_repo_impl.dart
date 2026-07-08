import 'package:injectable/injectable.dart';
import '../../domain/repositories/track_order_repo.dart';
import '../data_sources/remote/track_order_remote_data_source.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  final TrackOrderRemoteDataSource _trackOrderRemoteDataSource;

  TrackOrderRepoImpl(this._trackOrderRemoteDataSource);
}
