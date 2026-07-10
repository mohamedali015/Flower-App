enum OrderStatus {
  accepted,
  picked,
  outForDelivery,
  arrived,
  delivered;

  static OrderStatus fromString(String? status) {
    switch (status) {
      case 'accepted':
        return OrderStatus.accepted;
      case 'picked':
        return OrderStatus.picked;
      case 'outForDelivery':
        return OrderStatus.outForDelivery;
      case 'arrived':
        return OrderStatus.arrived;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.accepted;
    }
  }
}
