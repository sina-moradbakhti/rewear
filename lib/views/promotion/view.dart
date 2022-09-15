import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Promotion extends StatelessWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          centerTitle: false,
          main: false,
          title: Text(
            MyStrings.promotion_title,
            style: Get.theme.textTheme.headline6,
          )),
      body: Center(
        child: Text(
          'Comming soon',
          style: Get.theme.textTheme.bodyText2!
              .copyWith(fontWeight: FontWeight.w800, color: MyColors.darkGrey),
        ),
      ),
    );
  }
}
