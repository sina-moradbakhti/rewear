import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/registerType.enum.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/authentication.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignupWithAppleBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  var fullname = ''.obs;
  var email = ''.obs;
  RxBool loading = false.obs;

  String appleId = '';
  final services = AuthenticationServices();

  SignupWithAppleBloc() {
    final AuthorizationCredentialAppleID credential = Get.arguments;
    WidgetsFlutterBinding.ensureInitialized();
    fullname.value = '${credential.givenName} ${credential.familyName}';
    email.value = credential.email ?? '';
    appleId = credential.userIdentifier ?? '';
  }

  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }

  void signUp({RegisterType registerType = RegisterType.apple}) async {
    if (loading.value) return;

    String fullname = this.fullname.value;
    String email = this.email.value;

    loading.value = true; // Start loading ...
    final user = await services.registerWithApple(
        fullname: fullname,
        email: email,
        userType: selectedUserType.value.toString(),
        appleId: appleId);
    loading.value = false; // Stop loading
    if (user != null) {
      AppInit().user = user;
      await AppInit().user.saveToCacheAndLogin();
      Get.offAllNamed(MyRoutes.launch);
    }
  }
}
