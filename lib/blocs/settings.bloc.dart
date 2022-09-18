import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/confirm.modal.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/services/init.dart';

class SettingsBloc extends GetxController {
  final service = InitService();
  void profile() =>
      Get.toNamed(MyRoutes.profile, arguments: {'withoutAppbar': false});
  void terms() => AppInit().openLink(AppInit.TERMS_CONDITION_URL);
  void privacy() => AppInit().openLink(AppInit.PRIVACY_POLICY_URL);
  void contactUs() => AppInit().openLink(AppInit.CONTACT_US);
  void exit() async {
    Get.dialog(ConfirmDialog(
      onYepTapped: () async {
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
          await _exitFromApp();
        } catch (er) {
          Get.back();
          debugPrint('${er.runtimeType}');
          debugPrint('$er');
        }
      },
      okButton: "Yes",
      title: 'Are you sure to Log out?',
    ));
  }

  void removeAccount() async {
    Get.dialog(ConfirmDialog(
      onYepTapped: () async {
        await service.removeAccount();
        await _exitFromApp();
      },
      okButton: "Remove",
      title: 'Remove Account',
      caption:
          "Are you sure to do it?! by doing this, all your data will erase from our server permanently.",
    ));
  }

  _exitFromApp() async {
    await AppInit().user.signOut();
    AppInit().currentPosition = null;
    Get.offAllNamed(MyRoutes.welcome);
  }
}
