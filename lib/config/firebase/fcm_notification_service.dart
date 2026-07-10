import 'package:injectable/injectable.dart';
import '../../core/values/api_strings.dart';
import 'api/fcm_api_client.dart';
import 'data/models/fcm_request.dart';

@lazySingleton
class FcmNotificationService {
  final FcmApiClient _fcmApiClient;

  FcmNotificationService(this._fcmApiClient);

  Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    final projectId = SecretKeys.serviceAccountJson[ApiStrings.projectId] ?? '';

    await _fcmApiClient.sendNotification(
      projectId,
      FcmRequest(
        message: FcmMessage(
          token: fcmToken,
          notification: FcmNotification(title: title, body: body),
        ),
      ),
    );
  }
}
