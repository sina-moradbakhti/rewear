import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Repair extends StatelessWidget {
  const Repair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          centerTitle: false,
          main: false,
          title: Text(
            MyStrings.repair_title,
            style: Get.theme.textTheme.headline6,
          )),
    );
  }
}
