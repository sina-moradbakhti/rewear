import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/registerType.enum.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/authentication.dart';

class SignupWithGoogleBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  var fullname = ''.obs;
  var email = ''.obs;
  RxBool loading = false.obs;

  String googleId = '';
  final services = AuthenticationServices();

  SignupWithGoogleBloc() {
    final GoogleSignInAccount googleData = Get.arguments;
    WidgetsFlutterBinding.ensureInitialized();
    fullname.value = googleData.displayName ?? '';
    email.value = googleData.email;
    googleId = googleData.id;
  }

  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }

  void signUp({RegisterType registerType = RegisterType.emailPassword}) async {
    if (loading.value) return;

    String fullname = this.fullname.value;
    String email = this.email.value;

    loading.value = true; // Start loading ...
    final user = await services.registerWithGoogle(
        fullname: fullname,
        email: email,
        userType: selectedUserType.value.toString(),
        googleId: googleId);
    loading.value = false; // Stop loading
    if (user != null) {
      AppInit().user = user;
      await AppInit().user.saveToCacheAndLogin();
      Get.offAllNamed(MyRoutes.launch);
    }
  }
}
