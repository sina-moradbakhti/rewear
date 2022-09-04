import 'package:flutter/material.dart';
import 'package:rewear/models/order.dart';

class Request {
  String? id;
  String? sellerId;
  final String customerId;
  final Order order;
  bool seen = false;
  bool tailorSeen = false;
  bool acceptedBySeller = false;
  bool acceptedByUser = false;
  bool canceledBySeller = false;
  bool canceledByUser = false;
  String canceledExcuse = '';

  TimeOfDay? timeToDelivery;
  bool isReady = false;
  double price = 0;
  final DateTime orderDate;
  final DateTime deliveryToTailor;

  Request(
      {this.id,
      required this.order,
      required this.customerId,
      this.sellerId,
      this.seen = false,
      this.acceptedBySeller = false,
      this.acceptedByUser = false,
      this.timeToDelivery,
      this.isReady = false,
      required this.orderDate,
      this.canceledBySeller = false,
      this.canceledByUser = false,
      this.tailorSeen = false,
      this.canceledExcuse = '',
      this.price = 0,
      required this.deliveryToTailor});

  factory Request.fromJson(Map<String, dynamic> data) {
    return Request(
        id: data['_id'],
        seen: data['seen'] ?? false,
        tailorSeen: data['tailorSeen'] ?? false,
        sellerId: data['sellerId'],
        customerId: data['customerId'],
        acceptedBySeller: data['acceptedBySeller'],
        acceptedByUser: data['acceptedByUser'],
        canceledBySeller: data['canceledBySeller'] ?? false,
        canceledByUser: data['canceledByUser'] ?? false,
        canceledExcuse: data['cancelExcuse'] ?? '',
        isReady: data['isReady'],
        price: double.parse(data['price'].toString()),
        timeToDelivery: data['timeToDelivery'],
        orderDate: (data['orderDate']).toDate(),
        order: Order.fromJson(data['order']),
        deliveryToTailor: data['deliveryToTailor']);
  }
}
