import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';

class ShouldUpdateProfileDialog extends StatelessWidget {
  final List<String> emptyList;
  const ShouldUpdateProfileDialog({Key? key, required this.emptyList})
      : super(key: key);

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
                "to begin your professional at Rewear, you should complete your Tailory's profile.",
                style: Get.theme.textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: MyConstants.topPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mandetary fields,\nthat you have to fill them up",
                    style: Get.theme.textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Hr(),
                  ),
                  Wrap(
                    children: [
                      for (final emptyItem in emptyList)
                        Text(
                          '* $emptyItem  ',
                          style: Get.theme.textTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                    ],
                  )
                ],
              ),
            ),
            Image.asset(MyImages.tailory),
            Padding(
                padding: MyConstants.topDoublePadding,
                child: MyPrimaryButton(
                  onPressed: () {
                    Get.back(closeOverlays: true);
                    Get.toNamed(MyRoutes.profile,
                        arguments: {'withoutAppbar': false});
                  },
                  title: 'Update Profile',
                ))
          ],
        ),
      ),
    );
  }
}
