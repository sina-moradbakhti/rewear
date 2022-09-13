import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/verify.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class VerificationCode extends StatelessWidget {
  VerificationCode({Key? key}) : super(key: key);

  final bloc = Get.put(VerifyBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.vfc_title,
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
                  MyStrings.vfc_caption,
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                          onChanges: (newVal) => bloc.code.value = newVal,
                          title: MyStrings.code,
                          hint: 'Code'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => bloc.loading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.verifyCode,
                          title: MyStrings.vfc_button)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
