// import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/registerType.enum.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/http.services.dart';

class LoginBloc extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  RxBool loading = false.obs;

  final services = HttpServices();

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

  void login({RegisterType registerType = RegisterType.emailPassword}) async {
    if (loading.value) return;
    final _email = email.value;
    final _password = password.value;

    if (!loginCheck(_email, _password)) return;

    loading.value = true; // Start loading ...

    final user = await services.signIn(
        email: _email,
        password: _password,
        registerType: registerType.toString());

    loading.value = false; // Stop loading
    if (user != null) {
      AppInit().user = user;
      await AppInit().user.saveToCacheAndLogin();
      Get.offAllNamed(MyRoutes.home);
    }
  }
}
