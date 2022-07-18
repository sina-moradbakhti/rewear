import 'package:get/get.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/userType.enum.dart';

class LoginBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;

  void login() async {
    Get.offAllNamed(MyRoutes.home);
  }
}
