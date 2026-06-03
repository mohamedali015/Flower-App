import 'package:geocoding/geocoding.dart';

class Address {
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


}
