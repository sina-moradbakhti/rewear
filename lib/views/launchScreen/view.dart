import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/firestore.services.dart';

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);

  final app = AppInit();

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (app.isUserLoggedIn) {
      final freshData = await FirestoreServices().getUser(app.user.uid ?? '');
      final fcmToken = ''; // await FirebaseMessaging.instance.getToken();
      app.user = User.fromJson(freshData.data);
      app.user.docId = freshData.docId;
      app.user.fcmToken = fcmToken;
      await app.updateLastLocation(isBackground: true);
      await FirestoreServices()
          .updateUserWithDocId(freshData.docId, {'fcmToken': fcmToken});
      if (app.user.role == UserType.seller) {
        FirestoreServices().getRequests();
      }

      Get.offNamed(MyRoutes.home);
    } else {
      Get.offNamed(MyRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                MyImages.circularRewearLogo,
                width: Get.width / 2,
                height: Get.width / 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(
                    color: MyColors.white, strokeWidth: 1.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
