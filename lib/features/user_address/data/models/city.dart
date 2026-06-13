import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final int governorateId;
  final String cityNameAr;
  final String cityNameEn;

  const City({
    required this.id,
    required this.governorateId,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.parse(json['id'].toString()),
      governorateId: int.parse(json['governorate_id'].toString()),
      cityNameAr: json['city_name_ar'] ?? '',
      cityNameEn: json['city_name_en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate_id': governorateId,
      'city_name_ar': cityNameAr,
      'city_name_en': cityNameEn,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, governorateId, cityNameAr, cityNameEn];
}
