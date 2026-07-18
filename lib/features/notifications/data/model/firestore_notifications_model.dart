import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firestore_notifications_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FirestoreNotificationsModel {
  final NotificationContent? ar;
  final NotificationContent? en;

  FirestoreNotificationsModel({this.ar, this.en});

  factory FirestoreNotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreNotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreNotificationsModelToJson(this);

  NotificationContent? getContentForLanguage(String languageCode) {
    if (languageCode == 'ar') {
      return ar ?? en;
    }
    return en ?? ar;
  }
}

@JsonSerializable()
class NotificationContent {
  final String? id;
  final String? title;
  final String? body;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp? createdAt;

  NotificationContent({this.id, this.title, this.body, this.createdAt});

  factory NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationContentToJson(this);

  static Timestamp? _timestampFromJson(dynamic json) {
    if (json is Timestamp) return json;
    if (json is String) return Timestamp.fromDate(DateTime.parse(json));
    return null;
  }

  static dynamic _timestampToJson(Timestamp? timestamp) => timestamp;
}
