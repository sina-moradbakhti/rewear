import 'package:flutter/material.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                  alignment: Alignment.center,
                  height: size.height / 2,
                  color: MyColors.grey,
                ),
              ),
              Text(MyStrings.welcome_screen_slogan_title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPrimaryButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(MyRoutes.signup),
                      title: MyStrings.welcome_screen_getStarted_btn),
                  Padding(
                    padding: MyConstants.topPadding,
                    child: GoogleButton(onPressed: () {}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(MyStrings.welcome_screen_have_account_text,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center),
                  TextButton(
                    onPressed: null,
                    child: Text(MyStrings.welcome_screen_login_btn,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: MyColors.orange),
                        textAlign: TextAlign.center),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
