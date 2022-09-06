import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tailor {
  final String? uid;
  final String? fullname;
  String? fcmToken;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? image;
  final String? slogan;
  final String? description;
  final LatLng? position;
  String? cover;
  String? phone;
  final int? rate;

  Tailor(
      {this.fullname,
      this.uid,
      this.address,
      this.city,
      this.country,
      this.email,
      this.fcmToken,
      this.description,
      this.image,
      this.cover,
      this.phone,
      this.position,
      this.rate,
      this.slogan});
  factory Tailor.fromJson(Map<String, dynamic> json) {
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
    return Tailor(
      uid: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      fcmToken: json['fcmToken'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      image: json['image'],
      slogan: json['slogan'],
      description: json['description'],
      position: pos,
      cover: json['cover'],
      phone: json['phone'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'fcmToken': fcmToken,
      'address': address,
      'city': city,
      'country': country,
      'image': image,
      'slogan': slogan,
      'description': description,
      'position': position,
      'cover': cover,
      'phone': phone,
      'rate': rate,
    };
  }

  Map<String, dynamic> toJsonForFirestore({DateTime? updatedAt}) {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'fcmToken': fcmToken,
      'address': address,
      'city': city,
      'country': country,
      'image': image,
      'slogan': slogan,
      'description': description,
      'position': position,
      'cover': cover,
      'phone': phone,
      'rate': rate,
      'createdAt': DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now()
    };
  }
}
