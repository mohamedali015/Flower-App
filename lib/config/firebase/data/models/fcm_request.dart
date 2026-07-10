import 'package:json_annotation/json_annotation.dart';

part 'fcm_request.g.dart';

@JsonSerializable(explicitToJson: true)
class FcmRequest {
  final FcmMessage message;

  FcmRequest({required this.message});

  factory FcmRequest.fromJson(Map<String, dynamic> json) =>
      _$FcmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FcmRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FcmMessage {
  final String token;
  final FcmNotification notification;

  FcmMessage({required this.token, required this.notification});

  factory FcmMessage.fromJson(Map<String, dynamic> json) =>
      _$FcmMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FcmMessageToJson(this);
}

@JsonSerializable()
class FcmNotification {
  final String title;
  final String body;

  FcmNotification({required this.title, required this.body});

  factory FcmNotification.fromJson(Map<String, dynamic> json) =>
      _$FcmNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FcmNotificationToJson(this);
}
