import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';

class BadgeWidget extends StatelessWidget {
  final int count;
  const BadgeWidget({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        count.toString(),
        style: Get.theme.textTheme.caption!.copyWith(color: Colors.white),
      ),
      backgroundColor: MyColors.orange,
      radius: 11.5,
    );
  }
}
