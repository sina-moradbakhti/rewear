import 'dart:ui';
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

  final DateTime createdAt;
  DateTime? updatedAt;

  Order(
      {required this.createdAt,
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
        images: json['images'],
        description: json['description'],
        color: (json['color'] != null)
            ? (json['color'] ?? '').toString().toColor()
            : null,
        neckStyle: stringToNeckStyle(json['neckStyle']),
        serviceType: json['serviceType'],
        material: json['material'],
        price: json['price'],
        deliveryDate: json['deliveryDate'],
        tailorysDone: json['tailorysDone'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foundTailorId': foundTailorId,
      'images': images,
      'description': description,
      'color': color?.asString(),
      'neckStyle': neckStyle,
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
      'neckStyle': neckStyle,
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
