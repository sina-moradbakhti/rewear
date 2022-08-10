import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/views/findServices/serviceItem.widget.dart';

class CustomerServiceWidget extends StatelessWidget {
  CustomerServiceWidget({Key? key}) : super(key: key);

  final _list = [
    ServiceItemWidget(image: MyImages.repair, title: MyStrings.srvc_repair),
    ServiceItemWidget(
        image: MyImages.alteration, title: MyStrings.srvc_alteration),
    ServiceItemWidget(image: MyImages.redesign, title: MyStrings.srvc_redesign),
    ServiceItemWidget(
        image: MyImages.promotion, title: MyStrings.srvc_promotion),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyConstants.primaryPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                MyStrings.srvc_title,
                style: Get.theme.textTheme.headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                child: _list[0],
                onTap: () => Get.toNamed(MyRoutes.repair),
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: InkWell(
                child: _list[1],
                onTap: () => Get.toNamed(MyRoutes.alteration),
              )),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                child: _list[2],
                onTap: () => Get.toNamed(MyRoutes.redesign),
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: InkWell(
                child: _list[3],
                onTap: () => Get.toNamed(MyRoutes.promotion),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
