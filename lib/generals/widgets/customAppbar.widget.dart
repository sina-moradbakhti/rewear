import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final double _HEIGHT = 70;
  final Widget? title;
  final bool centerTitle;
  final bool main;
  const CustomAppbar(
      {Key? key, this.title, this.centerTitle = false, this.main = true})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
    if (main) {
      return AppBar(
        titleSpacing: 0,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        toolbarHeight: _HEIGHT,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Get.back(),
            icon: const Icon(IconlyFont.arrow___left)),
        elevation: 0,
        centerTitle: centerTitle,
        title: title ?? Container(),
      );
    } else {
      return AppBar(
        titleSpacing: 0,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        toolbarHeight: _HEIGHT,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Get.back(),
            icon: const Icon(IconlyFont.arrow___left_2)),
        elevation: 0,
        centerTitle: centerTitle,
        title: title ?? Container(),
        bottom: PreferredSize(
          preferredSize: Size(Get.size.width, 1),
          child: Container(
            height: 1,
            color: MyColors.grey,
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => Size(Get.size.width, _HEIGHT);
}
