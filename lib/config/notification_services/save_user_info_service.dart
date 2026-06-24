import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveUserInfoService {
  final FirebaseFirestore firestore;

  SaveUserInfoService(this.firestore);

  StreamSubscription? _tokenSub;

  Future<void> initUserDevice(String userId) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
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
      await firestore.collection('users').doc(userId).set({
        'fcmToken': fcmToken,
        'language': language,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  void _listenToTokenChanges(String userId) {
    _tokenSub?.cancel();

    _tokenSub = FirebaseMessaging.instance.onTokenRefresh.listen((
      newToken,
    ) async {
      await firestore.collection('users').doc(userId).update({
        'fcmToken': newToken,
      });
    });
  }

  void dispose() {
    _tokenSub?.cancel();
  }
}
