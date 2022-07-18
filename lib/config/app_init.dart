import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  User user = User(
      id: "",
      fullname: "Sina Moradbakhti",
      email: "sina_moradbakhti@yahoo.com",
      role: UserType.customer);
}
