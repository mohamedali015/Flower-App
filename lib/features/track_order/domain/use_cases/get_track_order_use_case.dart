import 'package:flower_app/config/error_handling/result.dart';
import 'package:injectable/injectable.dart';

import '../repositories/track_order_repo.dart';

@injectable
class GetTrackOrderUseCase {
  final TrackOrderRepo _repo;

  GetTrackOrderUseCase(this._repo);

  Future<Result<dynamic>> call(String orderId) async {
    // return _repo.getTrackOrder(orderId);
    return Failure(errorMessage: 'Not implemented');
  }
}
