import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/authentication.dart';

class VerifyBloc extends GetxController {
  Rx<UserType> selectedUserType = UserType.customer.obs;
  RxString code = ''.obs;
  RxBool loading = false.obs;

  String argEmail = '';
  final services = AuthenticationServices();

  VerifyBloc() {
    argEmail = Get.arguments;
  }

  Future<void> verifyCode() async {
    if (code.value.isEmpty) {
      AppInit().handleError(MyErrorException(
          message: 'you have to fill up the "Code field"', title: 'Code'));
      return;
    }
    if (code.value.length != 6) {
      AppInit().handleError(
          MyErrorException(message: 'Enter a valid Code', title: 'Code'));
      return;
    }

    if (argEmail == '') {
      AppInit().handleError(MyErrorException(
          message: 'Please enter your Email!', title: 'Email'));
      return;
    }

    loading.value = true;
    try {
      final result = await services.resetPasswordApproval(argEmail, code.value);
      loading.value = false;
      if (result) {
        Get.offNamed(MyRoutes.changePassword,
            arguments: {'email': argEmail, 'code': code.value});
      }
    } catch (er) {
      AppInit().handleError(er);
      loading.value = false;
      return;
    }
  }
}
