import 'package:json_annotation/json_annotation.dart';

part 'occasions.g.dart';

@JsonSerializable()
class Occasions {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  Occasions({
    this.Id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory Occasions.fromJson(Map<String, dynamic> json) {
    return _$OccasionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OccasionsToJson(this);
  }
}
