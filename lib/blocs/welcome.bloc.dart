import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/services/authentication.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class WelcomeBloc extends GetxController {
  var loading = false.obs;
  final services = AuthenticationServices();

  void signInByApple() async {
    try {
      loading.value = true;
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);
      if (credential.isBlank != null &&
          credential.email != null &&
          credential.userIdentifier != null) {
        final user = await services.appleSignInCheck(result: credential);
        if (user != null && user.id != '') {
          AppInit().user = user;
          await AppInit().user.saveToCacheAndLogin();
          Get.offAllNamed(MyRoutes.launch);
        } else {
          if (user?.id == '') {
            loading.value = false;
            Get.toNamed(MyRoutes.signupWithApple, arguments: credential);
          }
        }
      }
      loading.value = false;
    } catch (er) {
      loading.value = false;
      debugPrint(':::::::: APPLE SIGN IN ::::::::');
      debugPrint(er.toString());
    }
  }

  void signInByGoogle() async {
    try {
      loading.value = true;
      var result = await GoogleSignIn().signIn();
      if (result.isBlank != null &&
          result?.id != null &&
          result?.email != null) {
        final user = await services.googleSignInCheck(result: result!);
        if (user != null && user.id != '') {
          AppInit().user = user;
          await AppInit().user.saveToCacheAndLogin();
          Get.offAllNamed(MyRoutes.launch);
        } else {
          if (user?.id == '') {
            loading.value = false;
            Get.toNamed(MyRoutes.signupWithGoogle, arguments: result);
          }
        }
      }
      loading.value = false;
    } catch (er) {
      loading.value = false;
      debugPrint(':::::::: GOOGLE SIGN IN ::::::::');
      debugPrint(er.toString());
    }
  }
}
