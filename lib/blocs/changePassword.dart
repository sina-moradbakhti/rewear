import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/authentication.dart';
import 'package:rewear/generals/exts/extensions.dart';

class ChangePasswordBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  RxString password = ''.obs;
  RxString repassword = ''.obs;
  RxBool loading = false.obs;

  String argEmail = '';
  String argCode = '';
  final services = AuthenticationServices();

  ChangePasswordBloc() {
    argEmail = Get.arguments['email'];
    argCode = Get.arguments['code'];
  }

  Future<void> changePassword() async {
    if (password.value.isEmpty) {
      AppInit().handleError(MyErrorException(
          message: 'you have to fill up the "Password field"',
          title: 'Password'));
      return;
    }
    if (repassword.value.isEmpty) {
      AppInit().handleError(MyErrorException(
          message: 'you have to fill up the "Re-password field"',
          title: 'Re-password'));
      return;
    }
    if (repassword.value != password.value) {
      AppInit().handleError(MyErrorException(
          message: "Password and re-password isn't matched!",
          title: 'Password'));
      return;
    }
    if (!password.value.validatePassword()) {
      AppInit().handleError(MyErrorException(
          message: "Your passwortd isn't valid", title: 'Password'));
      return;
    }

    if (argEmail == '') {
      AppInit().handleError(MyErrorException(
          message: 'Please enter your Email!', title: 'Email'));
      return;
    }

    loading.value = true;
    try {
      final result = await services.changePassword(argEmail, password.value);
      loading.value = false;
      if (result) {
        Get.offAllNamed(MyRoutes.launch);
      }
    } catch (er) {
      AppInit().handleError(er);
      loading.value = false;
      return;
    }
  }
}
