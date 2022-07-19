import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Redesign extends StatelessWidget {
  const Redesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          centerTitle: false,
          main: false,
          title: Text(
            MyStrings.redesign_title,
            style: Get.theme.textTheme.headline6,
          )),
    );
  }
}
