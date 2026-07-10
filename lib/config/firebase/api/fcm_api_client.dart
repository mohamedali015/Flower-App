import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/values/api_end_points.dart';
import '../../../core/values/api_strings.dart';
import '../data/models/fcm_request.dart';

part 'fcm_api_client.g.dart';

@injectable
@RestApi()
abstract class FcmApiClient {
  @factoryMethod
  factory FcmApiClient(@Named(ApiStrings.fcmDio) Dio dio) = _FcmApiClient;

  @POST(ApiEndPoints.fcmSendPath)
  Future<void> sendNotification(
    @Path('projectId') String projectId,
    @Body() FcmRequest body,
  );
}
