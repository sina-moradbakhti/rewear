import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';

class UserTypeSelectorWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  UserTypeSelectorWidget(
      {Key? key, required this.title, this.isSelected = false})
      : super(key: key);

  final Map<String, Color> _ACTIVE_COLORS = {
    'dark': MyColors.orange,
    'light': MyColors.lightOrange
  };
  final Map<String, Color> _DEACTIVE_COLORS = {
    'dark': MyColors.darkGrey,
    'light': MyColors.lightGrey
  };

  @override
  Widget build(BuildContext context) {
    final Color darkC =
        isSelected ? _ACTIVE_COLORS['dark']! : _DEACTIVE_COLORS['dark']!;
    final Color lightC =
        isSelected ? _ACTIVE_COLORS['light']! : _DEACTIVE_COLORS['light']!;
    return Container(
      padding: const EdgeInsets.all(12.5),
      decoration: BoxDecoration(
          color: lightC,
          border: Border.all(width: 1.25, color: darkC),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              MySvgs.shoppingCart,
              color: darkC,
              width: 20,
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: Get.theme.textTheme.button!.copyWith(color: darkC),
              ),
            ),
          ]),
    );
  }
}
