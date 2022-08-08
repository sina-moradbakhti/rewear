import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/generals/exts/extensions.dart';

class Order {
  final String id;
  final String userId;
  String? foundTailorId;
  List<String>? images;
  String? description;
  Color? color;
  NeckStyle? neckStyle;
  String? serviceType;
  String? material;
  double? price;
  DateTime? deliveryDate;
  bool? tailorysDone;

  final DateTime? createdAt;
  DateTime? updatedAt;

  Order(
      {this.createdAt,
      this.updatedAt,
      this.description,
      this.foundTailorId,
      this.images,
      this.price,
      this.color,
      this.material,
      this.neckStyle,
      this.serviceType,
      required this.id,
      this.deliveryDate,
      this.tailorysDone,
      required this.userId});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        userId: json['userId'],
        foundTailorId: json['foundTailorId'],
        images: [for (final image in json['images']) image],
        description: json['description'],
        color: (json['color'] != null)
            ? (json['color'] ?? '').toString().toColor()
            : null,
        neckStyle: stringToNeckStyle(json['neckStyle']),
        serviceType: json['serviceType'],
        material: json['material'],
        price: json['price'],
        deliveryDate: (json['deliveryDate'] as Timestamp).toDate(),
        tailorysDone: json['tailorysDone'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foundTailorId': foundTailorId,
      'images': images,
      'description': description,
      'color': color?.asString(),
      'neckStyle': neckStyle != null ? neckStyleToString(neckStyle!) : null,
      'serviceType': serviceType,
      'material': material,
      'price': price,
      'deliveryDate': deliveryDate,
      'tailorysDone': tailorysDone,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  Map<String, dynamic> toJsonForFirestore({DateTime? updatedAt}) {
    return {
      'id': id,
      'userId': userId,
      'foundTailorId': foundTailorId,
      'images': images,
      'description': description,
      'color': color?.asString(),
      'neckStyle': neckStyle != null ? neckStyleToString(neckStyle!) : null,
      'serviceType': serviceType,
      'material': material,
      'price': price,
      'deliveryDate': deliveryDate,
      'tailorysDone': tailorysDone,
      'createdAt': DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now()
    };
  }
}
