import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/widgets/badge.widget.dart';
import 'package:rewear/models/userType.enum.dart';

class ServiceItemWidget extends StatelessWidget {
  final String title;
  final String image;
  final UserType type;
  final int badge;
  const ServiceItemWidget(
      {Key? key,
      required this.title,
      this.badge = 0,
      required this.image,
      this.type = UserType.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, size) => Container(
            width:
                type == UserType.customer ? (size.maxWidth / 2) : size.maxWidth,
            height: type == UserType.customer ? 220 : 150,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: MyColors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                badge > 0
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BadgeWidget(count: badge),
                        ),
                      )
                    : Container(),
                type == UserType.customer
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                              width: size.maxWidth / 1.5,
                              height: size.maxWidth / 1.5,
                              child: Image.asset(image),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                title,
                                style: Get.theme.textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          ])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, left: 20),
                              child: Text(
                                title,
                                style: Get.theme.textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.maxWidth / 1.8,
                              height: size.maxWidth / 1.8,
                              child: Image.asset(image),
                            ),
                          ]),
              ],
            )));
  }
}
