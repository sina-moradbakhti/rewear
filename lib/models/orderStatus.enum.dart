enum OrderStatus {
  pending,
  acceptedBySeller,
  rejectedBySeller,
  acceptedByBoth,
  rejectedByCustomer
}

String orderStatusToString(OrderStatus status) => status.toString();

OrderStatus stringToOrderStatus(String status) {
  switch (status) {
    case 'OrderStatus.pending':
      return OrderStatus.pending;
    case 'OrderStatus.acceptedBySeller':
      return OrderStatus.acceptedBySeller;
    case 'OrderStatus.rejectedBySeller':
      return OrderStatus.rejectedBySeller;
    case 'OrderStatus.acceptedByBoth':
      return OrderStatus.acceptedByBoth;
    case 'OrderStatus.rejectedByCustomer':
      return OrderStatus.rejectedByCustomer;
    default:
      return OrderStatus.pending;
  }
}
