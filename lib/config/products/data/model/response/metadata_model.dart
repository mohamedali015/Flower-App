import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  @JsonKey(name: 'currentPage')
  final num? currentPage;

  @JsonKey(name: 'totalPages')
  final num? totalPages;

  @JsonKey(name: 'limit')
  final num? limit;

  @JsonKey(name: 'totalItems')
  final num? totalItems;

  MetadataModel({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelFromJson(json);
}
