import 'package:flutter/material.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: MyConstants.primaryPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: MyConstants.primaryCircularRadius,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  alignment: Alignment.center,
                  height: Get.height / 2,
                  color: MyColors.lightGrey,
                  child: Image.asset(MyImages.tailorySlide01),
                ),
              ),
              Text(MyStrings.welcome_screen_slogan_title,
                  style: Get.theme.textTheme.headline5,
                  textAlign: TextAlign.center),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPrimaryButton(
                      onPressed: () => Get.toNamed(MyRoutes.signup),
                      title: MyStrings.welcome_screen_getStarted_btn),
                  Padding(
                    padding: MyConstants.topPadding,
                    child: GoogleButton(onPressed: () {}),
                  )
                ],
              ),
              MyTextButton(
                  onPressed: () => Get.toNamed(MyRoutes.login),
                  button: MyStrings.welcome_screen_login_btn,
                  text: MyStrings.welcome_screen_have_account_text)
            ],
          ),
        ),
      ),
    );
  }
}
