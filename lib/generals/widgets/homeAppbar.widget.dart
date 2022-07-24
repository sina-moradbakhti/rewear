import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/modals/cityPicker.modal.dart';
import 'package:rewear/generals/routes.dart';

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
      title: InkWell(
        onTap: () async {
          // Get.dialog(const CityPickerDialog(),
          //     useSafeArea: true,
          //     barrierColor: Colors.black87,
          //     transitionCurve: Curves.easeInOut);

          var res =
              await GeolocatorPlatform.instance.isLocationServiceEnabled();
          var checkh = await GeolocatorPlatform.instance.checkPermission();
          if (checkh != LocationPermission.whileInUse &&
              checkh != LocationPermission.always) {
            GeolocatorPlatform.instance.requestPermission();
          }

          print('Location Service : $res    |    $checkh');
        },
        child: Row(
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
              child: Text('Toronto', style: Get.theme.textTheme.bodyText1),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(IconlyFont.arrow___down_2, size: 18)),
          ],
        ),
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
