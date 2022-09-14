import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/services/authentication.dart';

class WelcomeBloc extends GetxController {
  final services = AuthenticationServices();

  void signInByGoogle() async {
    var result = await GoogleSignIn().signIn();
    if (result.isBlank != null && result?.id != null && result?.email != null) {
      final user = await services.googleSignInCheck(result: result!);
      if (user != null && user.id != '') {
        AppInit().user = user;
        await AppInit().user.saveToCacheAndLogin();
        Get.offAllNamed(MyRoutes.launch);
      } else {
        if (user?.id == '') {
          Get.toNamed(MyRoutes.signupWithGoogle, arguments: result);
        }
      }
    }
  }
}
