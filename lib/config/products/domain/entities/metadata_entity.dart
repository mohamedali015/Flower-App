import 'package:equatable/equatable.dart';

class MetadataEntity extends Equatable {
  final num currentPage;
  final num totalPages;
  final num limit;
  final num totalItems;

  const MetadataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, limit, totalItems];
}
