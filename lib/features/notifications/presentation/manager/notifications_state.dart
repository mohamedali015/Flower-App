import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_response_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/unread_count_response_entity.dart';

class NotificationsState extends Equatable {
  final BaseState<NotificationsResponseEntity> notificationsState;

  final BaseState<UnreadCountResponseEntity> unreadCountState;

  const NotificationsState({
    this.notificationsState = const BaseState(),
    this.unreadCountState = const BaseState(),
  });

  NotificationsState copyWith({
    BaseState<NotificationsResponseEntity>? notificationsStateParam,
    BaseState<UnreadCountResponseEntity>? unreadCountStateParam,
  }) {
    return NotificationsState(
      notificationsState: notificationsStateParam ?? notificationsState,
      unreadCountState: unreadCountStateParam ?? unreadCountState,
    );
  }

  @override
  List<Object?> get props => [notificationsState, unreadCountState];
}
