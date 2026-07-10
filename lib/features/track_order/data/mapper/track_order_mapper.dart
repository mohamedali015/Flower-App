import '../../domain/entities/track_order_entity.dart';
import '../models/response/track_order_response.dart';

extension TrackOrderResponseMapper on TrackOrderResponse? {
  TrackOrderEntity toEntity() {
    return TrackOrderEntity(
      id: this?.id ?? '',
      orderNumber: this?.orderNumber ?? '',
      orderStatus: this?.orderStatus ?? '',
      isActive: this?.isActive ?? false,
      driverId: this?.driverId ?? '',
      totalPrice: this?.totalPrice ?? 0,
      paymentType: this?.paymentType ?? '',
      isPaid: this?.isPaid ?? false,
      isDelivered: this?.isDelivered ?? false,
      state: this?.state ?? '',
      createdAt: this?.createdAt ?? '',
      updatedAt: this?.updatedAt ?? '',
      paidAt: this?.paidAt ?? '',
      v: this?.v ?? 0,
      user:
          this?.user.toEntity() ??
          const TrackOrderUserEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
            photo: '',
          ),
      store:
          this?.store.toEntity() ??
          const TrackOrderStoreEntity(
            name: '',
            image: '',
            phoneNumber: '',
            address: '',
            latLong: '',
          ),
      shippingAddress:
          this?.shippingAddress.toEntity() ??
          const TrackOrderShippingAddressEntity(
            street: '',
            city: '',
            phone: '',
            lat: '',
            long: '',
          ),
      orderItems: this?.orderItems?.map((e) => e.toEntity()).toList() ?? [],
      currentLocation:
          this?.currentLocation.toEntity() ??
          const TrackOrderCurrentLocationEntity(latitude: 0, longitude: 0),
    );
  }
}

extension UserMapper on User? {
  TrackOrderUserEntity toEntity() {
    return TrackOrderUserEntity(
      id: this?.id ?? '',
      firstName: this?.firstName ?? '',
      lastName: this?.lastName ?? '',
      email: this?.email ?? '',
      phone: this?.phone ?? '',
      photo: this?.photo ?? '',
    );
  }
}

extension StoreMapper on Store? {
  TrackOrderStoreEntity toEntity() {
    return TrackOrderStoreEntity(
      name: this?.name ?? '',
      image: this?.image ?? '',
      phoneNumber: this?.phoneNumber ?? '',
      address: this?.address ?? '',
      latLong: this?.latLong ?? '',
    );
  }
}

extension ShippingAddressMapper on ShippingAddress? {
  TrackOrderShippingAddressEntity toEntity() {
    return TrackOrderShippingAddressEntity(
      street: this?.street ?? '',
      city: this?.city ?? '',
      phone: this?.phone ?? '',
      lat: this?.lat ?? '',
      long: this?.long ?? '',
    );
  }
}

extension OrderItemMapper on OrderItem? {
  TrackOrderOrderItemEntity toEntity() {
    return TrackOrderOrderItemEntity(
      product:
          this?.product.toEntity() ??
          const TrackOrderProductEntity(
            id: '',
            title: '',
            imgCover: '',
            price: 0,
          ),
      price: this?.price ?? 0,
      quantity: this?.quantity?.toInt() ?? 0,
    );
  }
}

extension ProductMapper on Product? {
  TrackOrderProductEntity toEntity() {
    return TrackOrderProductEntity(
      id: this?.id ?? '',
      title: this?.title ?? '',
      imgCover: this?.imgCover ?? '',
      price: this?.price ?? 0,
    );
  }
}

extension CurrentLocationMapper on CurrentLocation? {
  TrackOrderCurrentLocationEntity toEntity() {
    return TrackOrderCurrentLocationEntity(
      latitude: this?.latitude ?? 0,
      longitude: this?.longitude ?? 0,
    );
  }
}
