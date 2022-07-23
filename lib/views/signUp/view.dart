import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/signup.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/textfields.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/signUp/selector.widget.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final bloc = Get.put(SignupBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: false,
        title: Text(
          MyStrings.signup_title,
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
                  MyStrings.signup_caption,
                  style: Get.theme.textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextfield(
                        title: MyStrings.signup_fullName_text,
                        controller: bloc.fullname,
                      ),
                      MyTextfield(
                          title: MyStrings.signup_email_text,
                          hint: 'Example@mail.com',
                          controller: bloc.email),
                      MyTextfield(
                          title: MyStrings.signup_password_text,
                          isPassword: true,
                          suffixIcon: IconlyFont.hide,
                          suffixIcon2: IconlyFont.show,
                          controller: bloc.password),
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
                const BreakWidget(size: 30),
                Center(
                  child: Text.rich(
                      TextSpan(
                          style: Get.theme.textTheme.bodyText2!
                              .copyWith(color: MyColors.darkGrey),
                          children: [
                            const TextSpan(
                                text:
                                    'By clicking Sign up, you agree to our\n'),
                            TextSpan(
                                text: MyStrings.termsCondition,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => AppInit()
                                      .openLink(AppInit.TERMS_CONDITION_URL),
                                style: Get.theme.textTheme.bodyText2!.copyWith(
                                    color: MyColors.orange,
                                    decoration: TextDecoration.underline)),
                            const TextSpan(text: ' and '),
                            TextSpan(
                                text: MyStrings.privacyStatement,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => AppInit()
                                      .openLink(AppInit.PRIVACY_POLICY_URL),
                                style: Get.theme.textTheme.bodyText2!.copyWith(
                                    color: MyColors.orange,
                                    decoration: TextDecoration.underline)),
                            const TextSpan(text: '.'),
                          ]),
                      textAlign: TextAlign.center),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Hr(),
                ),
                MyTextButton(
                    onPressed: () => Get.toNamed(MyRoutes.login),
                    button: MyStrings.welcome_screen_login_btn,
                    text: MyStrings.welcome_screen_have_account_text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
