import 'package:equatable/equatable.dart';

class GetAllCategoryEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;
  final bool? isSuperAdmin;
  final int? productsCount;

  const GetAllCategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.isSuperAdmin,
    required this.productsCount,
  });

  @override
  List<Object?> get props => [id, name, image, isSuperAdmin, productsCount];
}
