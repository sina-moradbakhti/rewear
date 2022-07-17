import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: MyConstants.primaryPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.signup_title,
                    style: Get.theme.textTheme.headline5,
                  ),
                  Padding(
                    padding: MyConstants.topHalfPadding,
                    child: Text(
                      MyStrings.signup_caption,
                      style: Get.theme.textTheme.subtitle2,
                    ),
                  )
                ],
              ),
              Padding(
                padding: MyConstants.topDoublePadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MyTextfield(title: MyStrings.signup_fullName_text),
                    MyTextfield(
                        title: MyStrings.signup_email_text,
                        hint: 'Example@mail.com'),
                    MyTextfield(
                        title: MyStrings.signup_password_text,
                        isPassword: true,
                        suffixIcon: IconlyFont.show),
                  ],
                ),
              ),
              MyPrimaryButton(onPressed: () {}, title: MyStrings.signup_title)
            ],
          ),
        ),
      ),
    );
  }
}
