import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeBloc extends GetxController {
  void signInByGoogle() async {
    var result = await GoogleSignIn().signIn();
    print(result);
  }
}
