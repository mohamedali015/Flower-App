import 'package:json_annotation/json_annotation.dart';

part 'credit_payment_request.g.dart';

@JsonSerializable()
class CheckoutPaymentRequest {
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;

  CheckoutPaymentRequest({this.shippingAddress});

  CheckoutPaymentRequest copyWith({ShippingAddress? shippingAddress}) =>
      CheckoutPaymentRequest(
        shippingAddress: shippingAddress ?? this.shippingAddress,
      );

  factory CheckoutPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutPaymentRequestToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  ShippingAddress({this.street, this.phone, this.city, this.lat, this.long});

  ShippingAddress copyWith({
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
  }) => ShippingAddress(
    street: street ?? this.street,
    phone: phone ?? this.phone,
    city: city ?? this.city,
    lat: lat ?? this.lat,
    long: long ?? this.long,
  );

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}
