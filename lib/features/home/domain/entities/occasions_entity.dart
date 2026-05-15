import 'package:equatable/equatable.dart';

class OccasionsEntity extends Equatable {
  final String? name;

  final String? image;

  const OccasionsEntity({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}
