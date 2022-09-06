import 'package:flutter/material.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/generals/exts/extensions.dart';
import 'package:rewear/models/user.dart';

class Request {
  String? id;
  User? seller;
  final User customer;
  bool seen = false;
  bool tailorSeen = false;
  bool acceptedBySeller = false;
  bool acceptedByUser = false;
  bool canceledBySeller = false;
  bool canceledByUser = false;
  String canceledExcuse = '';

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
      seller: User.fromJson(data['seller']),
      customer: User.fromJson(data['customer']),
      acceptedBySeller: data['acceptedBySeller'],
      acceptedByUser: data['acceptedByUser'],
      canceledBySeller: data['canceledBySeller'] ?? false,
      canceledByUser: data['canceledByUser'] ?? false,
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
