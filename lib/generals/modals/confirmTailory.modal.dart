import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class ConfirmTailoryDialog extends StatelessWidget {
  const ConfirmTailoryDialog({Key? key}) : super(key: key);

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
                Icons.question_mark,
                size: 60,
                color: MyColors.darkGrey,
              ),
              Text(
                "Confirmation",
                style: Get.theme.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: MyColors.darkGrey),
              ),
              Padding(
                padding: MyConstants.topPadding,
                child: Text(
                  "are you sure you wanna choose this tailory?",
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
                        onPressed: () {
                          Get.back();
                        },
                        title: 'Yeap!',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextButton(
                          child: Text('No',
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
