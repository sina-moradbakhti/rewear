import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/services/http.services.dart';

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);

  final app = AppInit();
  final services = HttpServices();

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (app.isUserLoggedIn) {
      await services.init();
      // FirestoreServices().getRequests(); // listen for new request
      await services.getTailorsNearby(); // listen for new tailors
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
