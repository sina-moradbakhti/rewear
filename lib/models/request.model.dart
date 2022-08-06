import 'package:flutter/material.dart';
import 'package:rewear/models/order.dart';

class Request {
  final String docId;
  final String sellerId;
  final String customerId;
  final Order order;
  bool seen = false;
  bool acceptedBySeller = false;
  bool acceptedByUser = false;
  TimeOfDay? timeToDelivery;
  bool isReady = false;
  double price = 0;
  final DateTime orderDate;

  Request(
      {required this.docId,
      required this.order,
      required this.customerId,
      required this.sellerId,
      this.seen = false,
      this.acceptedBySeller = false,
      this.acceptedByUser = false,
      this.timeToDelivery,
      this.isReady = false,
      required this.orderDate,
      this.price = 0});

  factory Request.fromJson(Map<String, dynamic> data) {
    return Request(
        docId: data['docId'],
        seen: data['seen'],
        sellerId: data['sellerId'],
        customerId: data['customerId'],
        acceptedBySeller: data['acceptedBySeller'],
        acceptedByUser: data['acceptedByUser'],
        isReady: data['isReady'],
        price: data['price'],
        timeToDelivery: data['timeToDelivery'],
        orderDate: data['orderDate'],
        order: Order.fromJson(data['order']));
  }

  Map<String, dynamic> toJsonForFirestore() {
    return {
      'docId': docId,
      'sellerId': sellerId,
      'customerId': customerId,
      'seen': seen,
      'acceptedBySeller': acceptedBySeller,
      'acceptedByUser': acceptedByUser,
      'isReady': isReady,
      'price': price,
      'timeToDelivery': timeToDelivery,
      'orderDate': orderDate,
      'order': order.toJsonForFirestore()
    };
  }
}
