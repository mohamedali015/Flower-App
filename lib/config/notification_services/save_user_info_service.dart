import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/config/notification_services/user_firestore_model.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveUserInfoService {
  final FirebaseFirestore firestore;
  final FirebaseMessaging firebaseMessaging;

  SaveUserInfoService(this.firestore, this.firebaseMessaging);

  StreamSubscription? _tokenSub;

  CollectionReference<UserFirestoreModel> get usersRef => firestore
      .collection(AppStrings.usersCollection)
      .withConverter<UserFirestoreModel>(
        fromFirestore: (snapshot, _) =>
            UserFirestoreModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<void> initUserDevice(String userId) async {
    final fcmToken = await firebaseMessaging.getToken();
    final language = PlatformDispatcher.instance.locale.languageCode;

    await _saveToFirestore(
      userId: userId,
      fcmToken: fcmToken,
      language: language,
    );

    _listenToTokenChanges(userId);
  }

  Future<void> _saveToFirestore({
    required String userId,
    required String? fcmToken,
    required String language,
  }) async {
    try {
      await usersRef
          .doc(userId)
          .set(
            UserFirestoreModel(
              fcmToken: fcmToken,
              language: language,
              updatedAt: Timestamp.now(),
            ),
            SetOptions(merge: true),
          );
    } catch (_) {}
  }

  void _listenToTokenChanges(String userId) {
    _tokenSub?.cancel();

    _tokenSub = firebaseMessaging.onTokenRefresh.listen((newToken) async {
      try {
        final doc = usersRef.doc(userId);
        final snapshot = await doc.get();

        if (!snapshot.exists || snapshot.data() == null) return;

        final user = snapshot.data()!;

        await doc.set(
          user.copyWith(fcmToken: newToken, updatedAt: Timestamp.now()),
          SetOptions(merge: true),
        );
      } catch (_) {}
    });
  }

  Future<void> updateUserLanguage({
    required String userId,
    required String language,
  }) async {
    try {
      final doc = usersRef.doc(userId);
      final snapshot = await doc.get();

      if (!snapshot.exists || snapshot.data() == null) return;

      final user = snapshot.data()!;

      await doc.set(
        user.copyWith(language: language, updatedAt: Timestamp.now()),
        SetOptions(merge: true),
      );
    } catch (_) {}
  }

  void dispose() {
    _tokenSub?.cancel();
  }
}
