import 'package:get/get.dart';
import 'package:rewear/models/userType.enum.dart';

class ForgotPasswordBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;

  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }
}
