import 'package:equatable/equatable.dart';

class UnreadCountResponseEntity extends Equatable {
  final num unreadCount;

  const UnreadCountResponseEntity({required this.unreadCount});

  @override
  List<Object> get props => [unreadCount];
}
