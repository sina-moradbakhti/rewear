// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/userType.enum.dart';

class ForgotPasswordBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  RxString email = ''.obs;
  RxBool loading = false.obs;
  RxBool showWarning = false.obs;

  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }

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
      // await FirebaseAuth.instance.sendPasswordResetEmail(email: email.value);
      // AppInit().handleError(MyErrorException(
      //     message: 'the reset password link is sent to your email',
      //     title: 'Successfully Sent'));
      // loading.value = false;
      // showWarning.value = true;
    } catch (er) {
      AppInit().handleError(er);
      loading.value = false;
      return;
    }
  }
}
