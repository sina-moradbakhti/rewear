import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/authentication.dart';

class ForgotPasswordBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  RxString email = ''.obs;
  RxBool loading = false.obs;
  RxBool showWarning = false.obs;

  final services = AuthenticationServices();

  Future<void> forgotPassword() async {
    if (email.isEmpty) {
      AppInit().handleError(MyErrorException(
          message: 'you have to fill up the "Email field"', title: 'Email'));
      return;
    }
    if (!email.value.isEmail) {
      AppInit().handleError(MyErrorException(
          message: 'Enter a valid email address', title: 'Email'));
      return;
    }

    loading.value = true;
    try {
      final result = await services.resetPassword(email.value);
      if (result) {
        showWarning.value = true;
        await Future.delayed(const Duration(seconds: 2));
        loading.value = false;
        Get.toNamed(MyRoutes.verificationCode, arguments: email.value);
      } else {
        loading.value = false;
      }
    } catch (er) {
      AppInit().handleError(er);
      loading.value = false;
      return;
    }
  }
}
