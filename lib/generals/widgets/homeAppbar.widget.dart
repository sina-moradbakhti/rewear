import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';

class HomeAppbar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  const HomeAppbar({Key? key, this.title, this.centerTitle = false})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: 0,
      actions: const [
        IconButton(
          icon: Icon(IconlyFont.search),
          onPressed: null,
        ),
      ],
      leading: const IconButton(
        icon: Icon(IconlyFont.category),
        onPressed: null,
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyFont.location,
            size: 21,
            color: MyColors.orange,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text('Amesterdam', style: Get.theme.textTheme.bodyText1),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(IconlyFont.arrow___down_2, size: 18)),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size(Get.size.width, 1),
        child: Container(
          height: 1,
          color: MyColors.grey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.size.width, 55);
}
