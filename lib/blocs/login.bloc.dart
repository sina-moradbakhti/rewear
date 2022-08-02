import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/firestore.services.dart';

class LoginBloc extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
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
    final _email = email.value;
    final _password = password.value;

    if (!loginCheck(_email, _password)) return;

    try {
      loading.value = true; // Start loading ...
      final credential = await fbAuth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      // Refresh Data
      final userJsonData =
          await FirestoreServices().getUser(credential.user?.uid ?? '');
      final User user = User.fromJson(userJsonData.data);
      user.docId = userJsonData.docId;
      await AppInit().updateUserData(
          credential: credential, isLogin: true, currentUser: user);
      // Refresh Data
      loading.value = false; // Stop loading
      Get.offAllNamed(MyRoutes.home);
    } catch (er) {
      loading.value = false; // Stop loading
      AppInit().handleError(er);
    }
  }
}
