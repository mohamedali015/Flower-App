import 'package:equatable/equatable.dart';

class NotificationsMetadataEntity extends Equatable {
  final num currentPage;
  final num totalPages;
  final num limit;
  final num totalItems;
  final num unreadCount;

  const NotificationsMetadataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
    required this.unreadCount,
  });

  @override
  List<Object> get props => [
    currentPage,
    totalPages,
    limit,
    totalItems,
    unreadCount,
  ];
}
