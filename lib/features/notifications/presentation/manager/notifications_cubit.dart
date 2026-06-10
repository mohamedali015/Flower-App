import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/use_case/get_notifications_use_case.dart';
import '../../domain/use_case/get_unread_count_use_case.dart';
import 'notifications_events.dart';
import 'notifications_state.dart';

@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotificationsUseCase, this._getUnreadCountUseCase)
    : super(const NotificationsState());

  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetUnreadCountUseCase _getUnreadCountUseCase;

  void doEvent(NotificationsEvents event) {
    switch (event) {
      case GetNotificationsEvent():
        _getNotifications();

      case GetUnreadCountEvent():
        _getUnreadCount();
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
}
