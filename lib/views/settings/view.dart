import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/settings.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final bloc = Get.put(SettingsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(
          MyStrings.settings_title,
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsItemWidget(
                title: MyStrings.profile,
                icon: Icons.perm_identity_rounded,
                onTapped: bloc.profile,
              ),
              SettingsItemWidget(
                title: MyStrings.termsCondition,
                icon: Icons.question_mark_outlined,
                onTapped: bloc.terms,
              ),
              SettingsItemWidget(
                title: MyStrings.privacyPolicy,
                icon: Icons.privacy_tip_outlined,
                onTapped: bloc.privacy,
              ),
              SettingsItemWidget(
                title: MyStrings.contactUs,
                icon: Icons.phone_rounded,
                onTapped: bloc.contactUs,
              ),
              SettingsItemWidget(
                title: MyStrings.logOut,
                icon: IconlyFont.logout,
                redColor: true,
                isTheLast: false,
                onTapped: bloc.exit,
              ),
              SettingsItemWidget(
                title: MyStrings.deactiveAccount,
                icon: IconlyFont.delete,
                redColor: true,
                isTheLast: true,
                onTapped: bloc.removeAccount,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTapped;
  final bool isTheLast;
  final bool redColor;
  const SettingsItemWidget(
      {Key? key,
      required this.title,
      this.icon,
      this.redColor = false,
      this.isTheLast = false,
      this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget button = InkWell(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Icon(icon,
                  color: redColor ? MyColors.red : MyColors.black, size: 22),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: redColor
                    ? Get.theme.textTheme.bodyText1!
                        .copyWith(color: MyColors.red)
                    : Get.theme.textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
    return isTheLast
        ? button
        : Column(
            children: [button, const Hr()],
          );
  }
}
