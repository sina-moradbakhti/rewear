import 'package:cloud_firestore/cloud_firestore.dart' as fbStore;
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';

class SignupBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool loading = false.obs;

  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }

  bool signupCheck(String fullname, String email, String password) {
    String title = '';
    String message = '';
    bool allow = true;

    if (fullname.isEmpty) {
      allow = false;
      title = 'Full name';
      message = 'Enter your full name';

      AppInit().handleError(MyErrorException(message: message, title: title));

      return allow;
    }
    if (email.isEmpty) {
      allow = false;
      title = 'Email';
      message = 'Enter your email';

      AppInit().handleError(MyErrorException(message: message, title: title));

      return allow;
    }
    if (!email.isEmail) {
      allow = false;
      title = 'Email';
      message = 'Enter a valid email address';

      AppInit().handleError(MyErrorException(message: message, title: title));

      return allow;
    }
    if (password.isEmpty) {
      allow = false;
      title = 'Password';
      message = 'Enter your password';

      AppInit().handleError(MyErrorException(message: message, title: title));

      return allow;
    }

    return allow;
  }

  void signUp() async {
    if (loading.value) return;

    String fullname = this.fullname.text;
    String email = this.email.text;
    String password = this.password.text;

    if (!signupCheck(fullname, email, password)) return;

    try {
      loading.value = true; // Start loading ...
      fbAuth.UserCredential credential = await fbAuth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var token = await credential.user?.getIdToken();
      final user = User(
          uid: credential.user?.uid,
          email: email,
          fullname: fullname,
          role: selectedUserType.value,
          token: token);
      await fbStore.FirebaseFirestore.instance
          .collection('users')
          .add(user.toJsonForFirestore());
      AppInit().user = user;
      await AppInit().user.saveToCacheAndLogin();
      loading.value = false; // Stop loading
      Get.offAllNamed(MyRoutes.home);
    } catch (error) {
      loading.value = false; // Stop loading
      AppInit().handleError(error);
    }
  }
}
