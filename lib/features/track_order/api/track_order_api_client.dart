import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'track_order_api_client.g.dart';

@injectable
@RestApi()
abstract class TrackOrderApiClient {
  @factoryMethod
  factory TrackOrderApiClient(Dio dio) = _TrackOrderApiClient;

  // TODO: Add endpoints
}
