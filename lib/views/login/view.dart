import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/login.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final bloc = Get.put(LoginBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.login_title,
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: MyConstants.primaryPadding.copyWith(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.login_caption,
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                          onChanges: bloc.email,
                          title: MyStrings.signup_email_text,
                          hint: 'Example@mail.com'),
                      MyTextfield(
                          onChanges: bloc.password,
                          title: MyStrings.signup_password_text,
                          isPassword: true,
                          suffixIcon: IconlyFont.hide,
                          suffixIcon2: IconlyFont.show),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => bloc.loading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.login, title: MyStrings.login_title)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: MyTextButton(
                      onPressed: () => Get.toNamed(MyRoutes.forgotPassword),
                      button: MyStrings.login_click_here,
                      text: MyStrings.login_forgot_password),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
