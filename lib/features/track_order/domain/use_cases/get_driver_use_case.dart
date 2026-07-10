import 'package:injectable/injectable.dart';
import '../entities/driver_entity.dart';
import '../repositories/track_order_repo.dart';

@injectable
class GetDriverUseCase {
  final TrackOrderRepo _repo;

  GetDriverUseCase(this._repo);

  Stream<DriverEntity> call(String driverId) {
    return _repo.watchDriver(driverId);
  }
}
