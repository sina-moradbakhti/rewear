import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeBloc extends GetxController {
  void signInByGoogle() async {
    var result = await GoogleSignIn().signIn();
    if (result.isBlank != null && result?.id != null && result?.email != null) {
      // print(result?.isBlank);
      print(result?.id);
      print(result?.displayName);
      print(result?.email);
      print(result?.photoUrl);
    }
  }
}
