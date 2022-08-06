import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/forgotPassword.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final bloc = Get.put(ForgotPasswordBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.fgp_title,
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
                  MyStrings.fgp_caption,
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                          onChanges: (newVal) => bloc.email.value = newVal,
                          title: MyStrings.signup_email_text,
                          hint: 'Example@mail.com'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => bloc.loading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.forgotPassword,
                          title: MyStrings.fgp_button)),
                ),
                _warningWidget
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _warningWidget => Obx(() => bloc.showWarning.value
      ? Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 20,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 20,
                    color: MyColors.darkGrey,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(
                    text: TextSpan(
                        style: Get.theme.textTheme.bodyText2!.copyWith(
                          color: MyColors.darkGrey,
                        ),
                        children: const [
                          TextSpan(text: "If you didn't get a "),
                          TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: "'Reset Password'"),
                          TextSpan(
                              text:
                                  " email yet, just you'd better to check your "),
                          TextSpan(
                              text: "'Spam'",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: " folder as well.")
                        ]),
                  ),
                ),
              )
            ],
          ),
        )
      : Container());
}
