import 'package:equatable/equatable.dart';

class Governorate extends Equatable {
  final int id;
  final String governorateNameAr;
  final String governorateNameEn;

  const Governorate({
    required this.id,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: int.parse(json['id'].toString()),
      governorateNameAr: json['governorate_name_ar'] ?? '',
      governorateNameEn: json['governorate_name_en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate_name_ar': governorateNameAr,
      'governorate_name_en': governorateNameEn,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, governorateNameAr, governorateNameEn];
}
