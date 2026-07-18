import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart'; // استيراد الـ Entity الجديد
import 'package:flower_app/features/notifications/domain/entities/notifications_response_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/unread_count_response_entity.dart';

class NotificationsState extends Equatable {
  final BaseState<NotificationsResponseEntity> notificationsState;
  final BaseState<UnreadCountResponseEntity> unreadCountState;

  // 1. إضافة الـ State الجديد المخصص للـ Firestore
  final BaseState<List<FirestoreNotificationEntity>>
  firestoreNotificationsState;

  const NotificationsState({
    this.notificationsState = const BaseState(),
    this.unreadCountState = const BaseState(),
    this.firestoreNotificationsState = const BaseState(), // القيمة الابتدائية
  });

  NotificationsState copyWith({
    BaseState<NotificationsResponseEntity>? notificationsStateParam,
    BaseState<UnreadCountResponseEntity>? unreadCountStateParam,
    BaseState<List<FirestoreNotificationEntity>>?
    firestoreNotificationsStateParam, // إضافة الحقل هنا
  }) {
    return NotificationsState(
      notificationsState: notificationsStateParam ?? notificationsState,
      unreadCountState: unreadCountStateParam ?? unreadCountState,
      firestoreNotificationsState:
          firestoreNotificationsStateParam ?? firestoreNotificationsState,
    );
  }

  @override
  // 2. إضافة الحقل الجديد داخل الـ props للـ Equatable
  List<Object?> get props => [
    notificationsState,
    unreadCountState,
    firestoreNotificationsState,
  ];
}
