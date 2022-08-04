import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/routes.dart';

class HomeAppbar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  HomeAppbar({Key? key, this.title, this.centerTitle = false})
      : super(key: key);

  final homeBloc = Get.put(HomeBloc());

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(IconlyFont.search),
          onPressed: () => Get.toNamed(MyRoutes.search),
        ),
      ],
      leading: IconButton(
        icon: const Icon(IconlyFont.category),
        onPressed: () => Get.toNamed(MyRoutes.settings),
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
            child: Obx(() => Text(homeBloc.currentCity.value,
                style: Get.theme.textTheme.bodyText1)),
          ),
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
