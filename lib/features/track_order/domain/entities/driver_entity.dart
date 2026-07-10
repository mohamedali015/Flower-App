import 'package:equatable/equatable.dart';

class DriverEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const DriverEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  String get fullName => "$firstName $lastName";

  @override
  List<Object?> get props => [firstName, lastName, email, phone];
}
