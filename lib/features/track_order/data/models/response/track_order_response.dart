import 'package:json_annotation/json_annotation.dart';

part 'track_order_response.g.dart';

@JsonSerializable()
class TrackOrderResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "orderStatus")
  final String? orderStatus;
  @JsonKey(name: "isActive")
  final bool? isActive;
  @JsonKey(name: "driverId")
  final String? driverId;
  @JsonKey(name: "totalPrice")
  final num? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "paidAt")
  final String? paidAt;
  @JsonKey(name: "__v")
  final num? v;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "store")
  final Store? store;
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;
  @JsonKey(name: "orderItems")
  final List<OrderItem>? orderItems;
  @JsonKey(name: "currentLocation")
  final CurrentLocation? currentLocation;

  TrackOrderResponse({
    this.id,
    this.orderNumber,
    this.orderStatus,
    this.isActive,
    this.driverId,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.paidAt,
    this.v,
    this.user,
    this.store,
    this.shippingAddress,
    this.orderItems,
    this.currentLocation,
  });

  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackOrderResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Store {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "latLong")
  final String? latLong;

  Store({this.name, this.image, this.address, this.phoneNumber, this.latLong});

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  ShippingAddress({this.street, this.city, this.phone, this.lat, this.long});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  final Product? product;
  @JsonKey(name: "price")
  final num? price;
  @JsonKey(name: "quantity")
  final num? quantity;

  OrderItem({this.product, this.price, this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "price")
  final num? price;

  Product({this.id, this.title, this.imgCover, this.price});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class CurrentLocation {
  @JsonKey(name: "latitude")
  final num? latitude;
  @JsonKey(name: "longitude")
  final num? longitude;

  CurrentLocation({this.latitude, this.longitude});

  factory CurrentLocation.fromJson(Map<String, dynamic> json) =>
      _$CurrentLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentLocationToJson(this);
}
