import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class SettingsBloc extends GetxController {
  void profile() =>
      Get.toNamed(MyRoutes.profile, arguments: {'withoutAppbar': false});
  void terms() => AppInit().openLink(AppInit.TERMS_CONDITION_URL);
  void privacy() => AppInit().openLink(AppInit.PRIVACY_POLICY_URL);
  void exit() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: 'Loging out',
        content: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: MyLoading(),
          ),
        ));
    try {
      await AppInit().user.signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(MyRoutes.welcome);
    } catch (er) {
      Get.back();
      debugPrint('${er.runtimeType}');
      debugPrint('$er');
    }
  }
}
