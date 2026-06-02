import 'package:equatable/equatable.dart';

class UnreadCountResponseEntity extends Equatable {
  final int unreadCount;

  const UnreadCountResponseEntity({required this.unreadCount});

  @override
  List<Object> get props => [unreadCount];
}
