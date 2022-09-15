import 'package:flutter/material.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/generals/exts/extensions.dart';
import 'package:rewear/models/orderStatus.enum.dart';
import 'package:rewear/models/user.dart';

class Request {
  String? id;
  User? seller;
  final User customer;
  bool sellerSeen = false;
  bool customerSeen = false;
  String canceledExcuse = '';
  OrderStatus orderStatus;

  List<String>? images;
  String? description;
  Color? color;
  NeckStyle? neckStyle;
  String? serviceType;
  String? material;

  TimeOfDay? timeToDelivery;
  bool isReady = false;
  double price = 0;
  final DateTime orderDate;
  final DateTime deliveryToTailor;

  Request(
      {this.id,
      this.images,
      this.description,
      this.color,
      this.neckStyle,
      this.serviceType,
      this.material,
      required this.customer,
      this.seller,
      this.sellerSeen = false,
      this.customerSeen = false,
      this.orderStatus = OrderStatus.pending,
      this.timeToDelivery,
      this.isReady = false,
      required this.orderDate,
      this.canceledExcuse = '',
      this.price = 0,
      required this.deliveryToTailor});

  factory Request.fromJson(Map<String, dynamic> data) {
    return Request(
      id: data['_id'],
      sellerSeen: data['sellerSeen'] ?? false,
      customerSeen: data['customerSeen'] ?? false,
      seller: User.fromJson(data['seller']),
      customer: User.fromJson(data['customer']),
      orderStatus: stringToOrderStatus(data['orderStatus']),
      canceledExcuse: data['cancelExcuse'] ?? '',
      isReady: data['isReady'],
      price: double.parse(data['price'].toString()),
      timeToDelivery: data['timeToDelivery'],
      orderDate: DateTime.parse(data['orderDate']),
      deliveryToTailor: DateTime.parse(data['deliveryToTailor']),
      images: [for (final image in data['images']) image],
      description: data['description'],
      color: (data['color'] != null)
          ? (data['color'] ?? '').toString().toColor()
          : null,
      neckStyle: stringToNeckStyle(data['neckStyle']),
      serviceType: data['serviceType'],
      material: data['material'],
    );
  }
}
