import 'package:flower_app/features/check_out/domain/Entities/cashorder_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cash_order_response.g.dart';

@JsonSerializable()
class CashOrderResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "order")
  final Order? order;

  CashOrderResponse({this.message, this.order});

  CashOrderResponse copyWith({String? message, Order? order}) =>
      CashOrderResponse(
        message: message ?? this.message,
        order: order ?? this.order,
      );

  factory CashOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CashOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashOrderResponseToJson(this);

  CashorderEntity toEntity() {
    return CashorderEntity();
  }
}

@JsonSerializable()
class Order {
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<OrderItem>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;

  Order({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  Order copyWith({
    String? user,
    List<OrderItem>? orderItems,
    int? totalPrice,
    String? paymentType,
    bool? isPaid,
    bool? isDelivered,
    String? state,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? orderNumber,
    int? v,
  }) => Order(
    user: user ?? this.user,
    orderItems: orderItems ?? this.orderItems,
    totalPrice: totalPrice ?? this.totalPrice,
    paymentType: paymentType ?? this.paymentType,
    isPaid: isPaid ?? this.isPaid,
    isDelivered: isDelivered ?? this.isDelivered,
    state: state ?? this.state,
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    orderNumber: orderNumber ?? this.orderNumber,
    v: v ?? this.v,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  final Product? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItem({this.product, this.price, this.quantity, this.id});

  OrderItem copyWith({
    Product? product,
    int? price,
    int? quantity,
    String? id,
  }) => OrderItem(
    product: product ?? this.product,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    id: id ?? this.id,
  );

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
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "id")
  final String? productId;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productId,
  });

  Product copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? discount,
    int? rateAvg,
    int? rateCount,
    int? sold,
    int? quantity,
    String? category,
    String? occasion,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? productId,
  }) => Product(
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    description: description ?? this.description,
    imgCover: imgCover ?? this.imgCover,
    images: images ?? this.images,
    price: price ?? this.price,
    priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
    discount: discount ?? this.discount,
    rateAvg: rateAvg ?? this.rateAvg,
    rateCount: rateCount ?? this.rateCount,
    sold: sold ?? this.sold,
    quantity: quantity ?? this.quantity,
    category: category ?? this.category,
    occasion: occasion ?? this.occasion,
    isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    productId: productId ?? this.productId,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
