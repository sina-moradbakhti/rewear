import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/iconly_font_icons.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  final double _HEIGHT = 70;
  final Widget? title;
  final bool centerTitle;
  const CustomAppbar({Key? key, this.title, this.centerTitle = false})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
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
  }

  @override
  Size get preferredSize => Size(Get.size.width, _HEIGHT);
}
