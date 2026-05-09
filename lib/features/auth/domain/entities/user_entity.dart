import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.userPhoto,
    required this.role,
    required this.wishList,
    required this.addresses,
    required this.createdAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String userPhoto;
  final String role;
  final List<dynamic> wishList;
  final List<dynamic> addresses;
  final DateTime createdAt;

  factory UserEntity.empty() {
    return UserEntity(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      gender: '',
      phone: '',
      userPhoto: '',
      role: '',
      wishList: const [],
      addresses: const [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    phone,
    userPhoto,
    role,
    wishList,
    addresses,
    createdAt,
  ];
}
