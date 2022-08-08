import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rewear/models/order.dart';

class Request {
  String? docId;
  String? sellerId;
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
      {this.docId,
      required this.order,
      required this.customerId,
      this.sellerId,
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
        price: double.parse(data['price'].toString()),
        timeToDelivery: data['timeToDelivery'],
        orderDate: (data['orderDate'] as Timestamp).toDate(),
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
