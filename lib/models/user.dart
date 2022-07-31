import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/models/userType.enum.dart';

class User {
  String? docId;
  final String? uid;
  String? fullname;
  String? token;
  final String? email;
  final UserType? role;
  String? address;
  String? image;
  String? cover;
  String? slogan;
  String? phone;
  String? description;
  LatLng? position;
  int? rate;

  User(
      {this.fullname,
      this.docId,
      this.uid,
      this.role,
      this.cover,
      this.email,
      this.token,
      this.address,
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
  factory User.fromJson(Map<String, dynamic> json) => User(
      docId: json['docId'],
      uid: json['uid'],
      address: json['address'],
      image: json['image'],
      cover: json['cover'],
      slogan: json['slogan'],
      description: json['description'],
      position: json['position'],
      rate: json['rate'],
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      token: json['token'],
      role: json['role'] == UserType.seller.toString()
          ? UserType.seller
          : UserType.customer);

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'token': token,
      'role': role.toString(),
      'address': address,
      'image': image,
      'cover': cover,
      'slogan': slogan,
      'phone': phone,
      'description': description,
      'position': position,
      'rate': rate
    };
  }

  Map<String, dynamic> toJsonForFirestore(
      {DateTime? updatedAt, bool createdAt = false}) {
    var obj = {
      'docId': docId,
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'token': token,
      'role': role.toString(),
      'address': address,
      'image': image,
      'cover': cover,
      'slogan': slogan,
      'phone': phone,
      'description': description,
      'position': position,
      'rate': rate,
      'updatedAt': updatedAt ?? DateTime.now()
    };
    if (createdAt) {
      obj.addAll({'createdAt': DateTime.now()});
    }
    return obj;
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
}
