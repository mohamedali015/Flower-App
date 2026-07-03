import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

class Address extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;
  final String? id;
  final List<Placemark>? placeMarks;

  const Address({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
    this.placeMarks,
  });

  Address copyWith({
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    String? username,
    String? id,
    List<Placemark>? placeMarks,
  }) {
    return Address(
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      username: username ?? this.username,
      id: id ?? this.id,
      placeMarks: placeMarks ?? this.placeMarks,
    );
  }

  @override
  List<Object?> get props =>
      [street, phone, city, lat, long, username, id, placeMarks];
}
