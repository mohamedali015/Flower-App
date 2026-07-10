import 'package:json_annotation/json_annotation.dart';

part 'open_route_response.g.dart';

@JsonSerializable()
class OpenRouteResponse {
  final List<Feature>? features;

  OpenRouteResponse({this.features});

  factory OpenRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenRouteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OpenRouteResponseToJson(this);
}

@JsonSerializable()
class Feature {
  final Geometry? geometry;

  Feature({this.geometry});

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable()
class Geometry {
  final List<List<double>>? coordinates;
  final String? type;

  Geometry({this.coordinates, this.type});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}
