import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/findServices/serviceItem.widget.dart';

class SellerServiceWidget extends StatelessWidget {
  const SellerServiceWidget({Key? key}) : super(key: key);

  final _list = const [
    ServiceItemWidget(
        image: MyImages.requests,
        title: MyStrings.tlrs_requests,
        type: UserType.seller),
    ServiceItemWidget(
        image: MyImages.catalogs,
        title: MyStrings.tlrs_catalog,
        type: UserType.seller),
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
                MyStrings.tlrs_title,
                style: Get.theme.textTheme.headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: _list[0],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: _list[1],
          ),
        ],
      ),
    );
  }
}
