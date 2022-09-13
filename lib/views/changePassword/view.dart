import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/changePassword.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final bloc = Get.put(ChangePasswordBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.cp_title,
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
                  MyStrings.cp_caption,
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                          onChanges: (newVal) => bloc.password.value = newVal,
                          title: MyStrings.signup_password_text,
                          hint: 'Password'),
                      MyTextfield(
                          onChanges: (newVal) => bloc.repassword.value = newVal,
                          title: MyStrings.signup_repassword_text,
                          hint: 'Re-password'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => bloc.loading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.changePassword,
                          title: MyStrings.cp_button)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors.lightOrange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password rules',
                              style: Get.theme.textTheme.bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          BreakWidget(size: 15, vertical: true),
                          Text('- At least 8 charcters',
                              style: Get.theme.textTheme.bodyText2!
                                  .copyWith(fontWeight: FontWeight.normal)),
                          BreakWidget(size: 8, vertical: true),
                          Text('- Includes at least 1 letter',
                              style: Get.theme.textTheme.bodyText2!
                                  .copyWith(fontWeight: FontWeight.normal)),
                          BreakWidget(size: 8, vertical: true),
                          Text('- Includes at least 1 number',
                              style: Get.theme.textTheme.bodyText2!
                                  .copyWith(fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
