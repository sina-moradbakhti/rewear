import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/break.widget.dart';

class CongratsDialog extends StatelessWidget {
  const CongratsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyImages.tailoryCongrats,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(MySvgs.receipt),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Your information was\nsuccessfully registered",
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: MyConstants.topDoublePadding,
                child: Row(
                  children: [
                    Expanded(
                        child: MyPrimaryButton(
                      designViceVersa: true,
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed(MyRoutes.home);
                        Get.toNamed(MyRoutes.requests);
                      },
                      title: 'Order tracking',
                    )),
                    BreakWidget(size: 15, vertical: false),
                    SizedBox(
                        width: 100,
                        child: MyPrimaryButton(
                          onPressed: () {
                            Get.back();
                            Get.offAllNamed(MyRoutes.home);
                          },
                          title: 'Home',
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
