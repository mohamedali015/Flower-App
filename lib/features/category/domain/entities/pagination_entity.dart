import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int? currentPage;
  final int? limit;
  final int? totalPages;
  final int? totalItems;

  const PaginationEntity({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [
    currentPage,
    limit,
    totalPages,
    totalItems,
  ];
}