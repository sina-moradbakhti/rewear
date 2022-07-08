import 'package:flutter/material.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: MyConstants.topHalfPadding,
                    child: Text(
                      MyStrings.signup_caption,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              ),
              Padding(
                padding: MyConstants.topDoublePadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextfield(title: MyStrings.signup_fullName_text),
                    MyTextfield(title: MyStrings.signup_email_text),
                    MyTextfield(title: MyStrings.signup_password_text),
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
