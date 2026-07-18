import 'dart:async'; // نحتاجها للتعامل مع الـ StreamSubscription
import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';
import 'package:flower_app/features/notifications/domain/use_case/watch_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/entities/notification_entity.dart'; // تأكدي من استيراد الـ Entity المتوقع داخل الـ Response القديم
import '../../domain/entities/notifications_response_entity.dart';
import '../../domain/use_case/get_notifications_use_case.dart';
import '../../domain/use_case/get_unread_count_use_case.dart';
import 'notifications_events.dart';
import 'notifications_state.dart';

@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
    this._getNotificationsUseCase,
    this._getUnreadCountUseCase,
    this._watchNotificationsUseCase,
  ) : super(const NotificationsState());

  final WatchNotificationsUseCase _watchNotificationsUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetUnreadCountUseCase _getUnreadCountUseCase;

  // متغير لحفظ اشتراك الـ Stream عشان نقفله لما الـ Cubit يقفل وميحصلش Memory Leak
  StreamSubscription? _notificationsSubscription;

  void doEvent(NotificationsEvents event) {
    switch (event) {
      case GetNotificationsEvent():
        _getNotifications();

      case GetUnreadCountEvent():
        _getUnreadCount();

      case GetFiretoreNotificationsEvent():
        _getFirestoreNotifications(
          userId: event.userId,
          languageCode: event.languageCode,
        );
    }
  }

  void _getFirestoreNotifications({
    required String userId,
    required String languageCode,
  }) {
    // إلغاء أي اشتراك قديم في حال تم استدعاء الميثود مجدداً
    _notificationsSubscription?.cancel();

    emit(
      state.copyWith(
        notificationsStateParam: state.notificationsState.copyWith(
          isLoadingParam: true,
          isSuccessParam: false,
          errorMessageParam: null,
        ),
      ),
    );

    try {
      // استدعاء الـ Use Case كميثود عادية بـ Positional arguments
      final stream = _watchNotificationsUseCase.call(userId, languageCode);

      _notificationsSubscription = stream.listen(
        (firestoreNotificationsList) {
          emit(
            state.copyWith(
              firestoreNotificationsStateParam: state
                  .firestoreNotificationsState
                  .copyWith(
                    isLoadingParam: false,
                    isSuccessParam: true,
                    dataParam:
                        firestoreNotificationsList, // تمرير اللستة مباشرة هنا
                  ),
            ),
          );
        },
        // ... onError
      );
    } catch (e) {
      emit(
        state.copyWith(
          notificationsStateParam: state.notificationsState.copyWith(
            isLoadingParam: false,
            isSuccessParam: false,
            errorMessageParam: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _getNotifications() async {
    emit(
      state.copyWith(
        notificationsStateParam: state.notificationsState.copyWith(
          isLoadingParam: true,
          isSuccessParam: false,
          errorMessageParam: null,
        ),
      ),
    );

    final result = await _getNotificationsUseCase.call();

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            notificationsStateParam: state.notificationsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            notificationsStateParam: state.notificationsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _getUnreadCount() async {
    emit(
      state.copyWith(
        unreadCountStateParam: state.unreadCountState.copyWith(
          isLoadingParam: true,
          isSuccessParam: false,
          errorMessageParam: null,
        ),
      ),
    );

    final result = await _getUnreadCountUseCase.call();

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            unreadCountStateParam: state.unreadCountState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            unreadCountStateParam: state.unreadCountState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  // إغلاق اشتراك الـ StreamSubscription فور تدمير الـ Cubit لحماية موارد الـ Memory
  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
