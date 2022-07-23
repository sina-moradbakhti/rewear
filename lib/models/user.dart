import 'package:get_storage/get_storage.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/models/userType.enum.dart';

class User {
  final String? uid;
  final String? fullname;
  String? token;
  final String? email;
  final UserType? role;

  User({this.fullname, this.uid, this.role, this.email, this.token});
  factory User.fromCache() {
    final box = GetStorage();
    if (box.read(MyConstants.USER_DATA_ID) == null) {
      return User();
    }
    return User.fromJson(box.read(MyConstants.USER_DATA_ID));
  }
  factory User.fromJson(Map<String, dynamic> json) => User(
      uid: json['uid'],
      email: json['email'],
      fullname: json['fullname'],
      token: json['token'],
      role: json['role'] == UserType.seller.toString()
          ? UserType.seller
          : UserType.customer);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'token': token,
      'role': role.toString()
    };
  }

  Map<String, dynamic> toJsonForFirestore({DateTime? updatedAt}) {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'token': token,
      'role': role.toString(),
      'createdAt': DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now()
    };
  }

  Future<void> saveToCacheAndLogin() async {
    final box = GetStorage();
    box.write(MyConstants.USER_IS_LOGIN_ID, true);
    box.write(MyConstants.USER_DATA_ID, toJson());
    await box.save();
  }

  Future<void> signOut() async {
    final box = GetStorage();
    await box.erase();
    await box.save();
  }
}
