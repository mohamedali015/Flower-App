import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final String? name;

  final String? image;

  const CategoriesEntity({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}
