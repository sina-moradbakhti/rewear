import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/confirm.modal.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/services/init.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsBloc extends GetxController {
  final service = InitService();
  final InAppReview inAppReview = InAppReview.instance;
  void profile() =>
      Get.toNamed(MyRoutes.profile, arguments: {'withoutAppbar': false});
  void terms() => AppInit().openLink(AppInit.TERMS_CONDITION_URL);
  void privacy() => AppInit().openLink(AppInit.PRIVACY_POLICY_URL);
  void contactUs() => AppInit().openLink(AppInit.CONTACT_US);
  void leaveReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }else{
      inAppReview.openStoreListing(appStoreId: '1644390864');
    }
  }

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
        final removeResult = await service.removeAccount();
        if (removeResult) {
          await _exitFromApp();
        } else {
          AppInit().handleError(MyErrorException(
              message:
                  'An error occured while removing account, please try again couple of minutes later.',
              title: 'Error'));
        }
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
