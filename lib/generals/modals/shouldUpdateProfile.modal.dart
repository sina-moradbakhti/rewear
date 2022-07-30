import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';

class ShouldUpdateProfileDialog extends StatelessWidget {
  const ShouldUpdateProfileDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tailory's Profile",
              style: Get.theme.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: MyConstants.topPadding,
              child: Text(
                "to begin your professional at Rewear, you should complete your Tailory's profile.\n\nnotice, you'll receive the orders after passing this step.",
                style: Get.theme.textTheme.bodyText1,
              ),
            ),
            Image.asset(MyImages.tailory),
            Padding(
                padding: MyConstants.topDoublePadding,
                child: MyPrimaryButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                    Get.toNamed(MyRoutes.profile);
                  },
                  title: 'Update Profile',
                ))
          ],
        ),
      ),
    );
  }
}
