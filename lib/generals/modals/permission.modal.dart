import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class PermissionLocationDialog extends StatelessWidget {
  const PermissionLocationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off_rounded,
                size: 60,
                color: MyColors.darkGrey,
              ),
              Text(
                "Permission denied",
                style: Get.theme.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: MyColors.darkGrey),
              ),
              Padding(
                padding: MyConstants.topPadding,
                child: Text(
                  "We cannot obtain your location information.",
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyText1!
                      .copyWith(color: MyColors.darkGrey),
                ),
              ),
              Padding(
                  padding: MyConstants.topDoublePadding * 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyPrimaryButton(
                        onPressed: () async {
                          Get.back();
                          await GeolocatorPlatform.instance.requestPermission();
                        },
                        title: 'Grant permission',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextButton(
                          child: Text('cancel',
                              style: Get.theme.textTheme.bodyText1!
                                  .copyWith(color: MyColors.darkGrey)),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
