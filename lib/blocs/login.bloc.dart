import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart' as fbStore;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/user.dart';

class LoginBloc extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool loading = false.obs;

  bool loginCheck(String email, String password) {
    String title = '';
    String message = '';
    bool allow = true;

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

  void login() async {
    if (loading.value) return;
    final _email = email.text;
    final _password = password.text;

    if (!loginCheck(_email, _password)) return;

    try {
      loading.value = true; // Start loading ...
      final credential = await fbAuth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      var token = await credential.user?.getIdToken();

      final doc = await fbStore.FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: credential.user?.uid)
          .get();
      final user = User.fromJson(doc.docs.first.data());
      user.token = token;
      AppInit().user = user;
      await AppInit().user.saveToCacheAndLogin();
      await fbStore.FirebaseFirestore.instance
          .collection('users')
          .doc(doc.docs.first.id)
          .update({'token': token});
      loading.value = false; // Stop loading
      Get.offAllNamed(MyRoutes.home);
    } catch (er) {
      loading.value = false; // Stop loading
      AppInit().handleError(er);
    }
  }
}
