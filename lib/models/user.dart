import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/models/userType.enum.dart';

class User {
  final String? id;
  String? fullname;
  String? token;
  String? fcmToken;
  final String? email;
  final UserType? role;
  String? address;
  String? city;
  String? country;
  String? image;
  String? cover;
  String? slogan;
  String? phone;
  String? description;
  LatLng? position;
  int? rate;

  User(
      {this.fullname,
      this.id,
      this.role,
      this.cover,
      this.email,
      this.token,
      this.fcmToken,
      this.address,
      this.city,
      this.country,
      this.description,
      this.image,
      this.phone,
      this.position,
      this.rate,
      this.slogan});

  factory User.fromCache() {
    final box = GetStorage();
    if (box.read(MyConstants.USER_DATA_ID) == null) {
      return User();
    }
    return User.fromJson(box.read(MyConstants.USER_DATA_ID));
  }

  factory User.fromJson(Map<String, dynamic> json) {
    LatLng? pos;
    if (json['position'] != null) {
      if (json['position'].runtimeType == List<dynamic>) {
        pos = LatLng(double.parse(json['position'][0].toString()),
            double.parse(json['position'][1].toString()));
      } else {
        final posSplited = json['position'].toString().split(',');
        pos = LatLng(double.parse(posSplited[0].toString()),
            double.parse(posSplited[1].toString()));
      }
    }

    return User(
        id: json['_id'],
        address: json['address'],
        country: json['country'],
        city: json['city'],
        image: json['image'],
        cover: json['cover'],
        slogan: json['slogan'],
        description: json['description'],
        position: pos,
        rate: json['rate'],
        email: json['email'],
        fullname: json['fullname'],
        phone: json['phone'],
        token: json['token'],
        fcmToken: json['fcmToken'],
        role: json['role'] == UserType.seller.toString()
            ? UserType.seller
            : UserType.customer);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'token': token,
      'fcmToken': fcmToken,
      'role': role.toString(),
      'address': address,
      'country': country,
      'city': city,
      'image': image,
      'cover': cover,
      'slogan': slogan,
      'phone': phone,
      'description': description,
      'position': position != null
          ? '${position!.latitude},${position!.longitude}'
          : null,
      'rate': rate
    };
  }

  Future<void> saveToCacheAndLogin() async {
    final box = GetStorage();
    box.write(MyConstants.USER_IS_LOGIN_ID, true);
    box.write(MyConstants.USER_DATA_ID, toJson());
    await box.save();
  }

  Future<void> updateCache() async {
    final box = GetStorage();
    box.write(MyConstants.USER_DATA_ID, toJson());
    await box.save();
  }

  Future<void> signOut() async {
    final box = GetStorage();
    await box.erase();
    await box.save();
  }

  LatLng? convertLatLng(var jsonData) {
    if (jsonData != null) {
      final posSplited = jsonData.toString().split(',');
      return LatLng(double.parse(posSplited[0].toString()),
          double.parse(posSplited[1].toString()));
    }

    return null;
  }
}
