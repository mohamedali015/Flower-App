import 'package:flower_app/config/products/data/model/response/metadata_model.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_dto.g.dart';

@JsonSerializable()
class OrdersDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataModel? metadata;
  @JsonKey(name: "orders")
  final List<Orders>? orders;

  OrdersDto({this.message, this.metadata, this.orders});

  factory OrdersDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersDtoToJson(this);
  }
}
