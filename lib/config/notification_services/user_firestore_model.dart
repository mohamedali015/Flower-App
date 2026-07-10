import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestoreModel {
  final String? fcmToken;
  final String language;
  final Timestamp? updatedAt;

  UserFirestoreModel({this.fcmToken, required this.language, this.updatedAt});

  factory UserFirestoreModel.fromJson(Map<String, dynamic> json) {
    return UserFirestoreModel(
      fcmToken: json['fcmToken'] as String?,
      language: json['language'] as String? ?? 'en',
      updatedAt: json['updatedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'fcmToken': fcmToken, 'language': language, 'updatedAt': updatedAt};
  }

  UserFirestoreModel copyWith({
    String? fcmToken,
    String? language,
    Timestamp? updatedAt,
  }) {
    return UserFirestoreModel(
      fcmToken: fcmToken ?? this.fcmToken,
      language: language ?? this.language,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
