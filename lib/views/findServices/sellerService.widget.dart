import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/models/mainNavItem.enum.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/findServices/serviceItem.widget.dart';

class SellerServiceWidget extends StatelessWidget {
  SellerServiceWidget({Key? key}) : super(key: key);

  final _list = [
    ServiceItemWidget(
        image: MyImages.requests,
        title: MyStrings.tlrs_requests,
        type: UserType.seller),
    ServiceItemWidget(
        image: MyImages.catalogs,
        title: MyStrings.tlrs_catalog,
        type: UserType.seller),
  ];

  final homeBloc = Get.find<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    _list[0].badge = AppInit()
        .requests
        .where((req) =>
            (!req.acceptedBySeller && !req.canceledBySeller) || !req.tailorSeen)
        .toList()
        .length;
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
                style: Get.theme.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.toNamed(AppInit().user.role == UserType.seller
                ? MyRoutes.tailorRequests
                : MyRoutes.requests),
            child: _list[0],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => homeBloc.changeTab(MainNavItem.orders),
            child: _list[1],
          ),
        ],
      ),
    );
  }
}
