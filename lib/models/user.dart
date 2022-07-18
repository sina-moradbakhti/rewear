import 'package:rewear/models/userType.enum.dart';

class User {
  final String? id;
  final String? fullname;
  final String? email;
  final UserType? role;

  User({this.fullname, this.id, this.role, this.email});
}
