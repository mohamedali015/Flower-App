import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

class Address extends Equatable {
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;
  String? username;
  String? id;
  List<Placemark>? placeMarks;

  Address({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
    this.placeMarks,
  });

  @override
  List<Object?> get props => [street, phone, city, lat, long, username, id];
}
