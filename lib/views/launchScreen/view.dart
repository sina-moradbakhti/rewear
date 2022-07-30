import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/services/firestore.services.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      FirestoreServices().getUser(AppInit().user.uid ?? '').then((freshData) {
        AppInit().user = User.fromJson(freshData.data);
        AppInit().user.docId = freshData.docId;
        AppInit().isUserLoggedIn
            ? Get.offNamed(MyRoutes.home)
            : Get.offNamed(MyRoutes.welcome);
      });
    });

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
