import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/signupWithGoogle.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/signUp/selector.widget.dart';

class SignUpWithGoogle extends StatelessWidget {
  SignUpWithGoogle({Key? key}) : super(key: key);

  final bloc = Get.put(SignupWithGoogleBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.signup_google_title,
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
                  '${MyStrings.signup_caption_dynamic} ${bloc.fullname}',
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () =>
                                      bloc.changeUserType(UserType.customer),
                                  child: UserTypeSelectorWidget(
                                    title: 'Customer',
                                    isSelected: bloc.selectedUserType.value ==
                                        UserType.customer,
                                  ),
                                )),
                                const SizedBox(width: 20),
                                Expanded(
                                    child: InkWell(
                                  onTap: () =>
                                      bloc.changeUserType(UserType.seller),
                                  child: UserTypeSelectorWidget(
                                    title: 'Seller',
                                    isSelected: bloc.selectedUserType.value ==
                                        UserType.seller,
                                  ),
                                )),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Obx(() => bloc.loading.value
                      ? const Center(child: MyLoading())
                      : MyPrimaryButton(
                          onPressed: bloc.signUp,
                          title: MyStrings.signup_title)),
                ),
                BreakWidget(size: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
