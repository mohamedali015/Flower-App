import 'package:json_annotation/json_annotation.dart';

part 'update_cart_request.g.dart';

@JsonSerializable()
class UpdateCartRequest {
  @JsonKey(name: "quantity")
  final int? quantity;

  UpdateCartRequest ({
    this.quantity,
  });

  factory UpdateCartRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateCartRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateCartRequestToJson(this);
  }
}


