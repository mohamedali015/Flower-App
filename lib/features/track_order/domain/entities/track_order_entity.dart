import 'package:equatable/equatable.dart';

class TrackOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String orderStatus;
  final bool isActive;
  final String driverId;
  final num totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String paidAt;
  final num v;
  final TrackOrderUserEntity user;
  final TrackOrderStoreEntity store;
  final TrackOrderShippingAddressEntity shippingAddress;
  final List<TrackOrderOrderItemEntity> orderItems;
  final TrackOrderCurrentLocationEntity currentLocation;

  const TrackOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.orderStatus,
    required this.isActive,
    required this.driverId,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.paidAt,
    required this.v,
    required this.user,
    required this.store,
    required this.shippingAddress,
    required this.orderItems,
    required this.currentLocation,
  });

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    orderStatus,
    isActive,
    driverId,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    paidAt,
    v,
    user,
    store,
    shippingAddress,
    orderItems,
    currentLocation,
  ];
}

class TrackOrderUserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;

  const TrackOrderUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, phone, photo];
}

class TrackOrderStoreEntity extends Equatable {
  final String name;
  final String image;
  final String phoneNumber;
  final String address;
  final String latLong;

  const TrackOrderStoreEntity({
    required this.name,
    required this.image,
    required this.phoneNumber,
    required this.address,
    required this.latLong,
  });

  @override
  List<Object?> get props => [name, image, phoneNumber, address, latLong];
}

class TrackOrderShippingAddressEntity extends Equatable {
  final String street;
  final String city;
  final String phone;
  final String lat;
  final String long;

  const TrackOrderShippingAddressEntity({
    required this.street,
    required this.city,
    required this.phone,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [street, city, phone, lat, long];
}

class TrackOrderOrderItemEntity extends Equatable {
  final TrackOrderProductEntity product;
  final num price;
  final int quantity;

  const TrackOrderOrderItemEntity({
    required this.product,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product, price, quantity];
}

class TrackOrderProductEntity extends Equatable {
  final String id;
  final String title;
  final String imgCover;
  final num price;

  const TrackOrderProductEntity({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, imgCover, price];
}

class TrackOrderCurrentLocationEntity extends Equatable {
  final num latitude;
  final num longitude;

  const TrackOrderCurrentLocationEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
