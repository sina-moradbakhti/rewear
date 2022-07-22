import 'package:flutter/material.dart';
import 'package:rewear/blocs/welcome.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/widgets/break.widget.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final bloc = Get.put(WelcomeBloc());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: MyConstants.primaryPadding.copyWith(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: MyConstants.primaryCircularRadius,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    alignment: Alignment.center,
                    height: Get.height / 2,
                    color: MyColors.lightGrey,
                    child: Image.asset(MyImages.tailorySlide01),
                  ),
                ),
                const BreakWidget(size: 20),
                Text(MyStrings.welcome_screen_slogan_title,
                    style: Get.theme.textTheme.headline5,
                    textAlign: TextAlign.center),
                const BreakWidget(size: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyPrimaryButton(
                        onPressed: () => Get.toNamed(MyRoutes.signup),
                        title: MyStrings.welcome_screen_getStarted_btn),
                    Padding(
                      padding: MyConstants.topPadding,
                      child: GoogleButton(onPressed: bloc.signInByGoogle),
                    )
                  ],
                ),
                const BreakWidget(size: 20),
                MyTextButton(
                    onPressed: () => Get.toNamed(MyRoutes.login),
                    button: MyStrings.welcome_screen_login_btn,
                    text: MyStrings.welcome_screen_have_account_text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
