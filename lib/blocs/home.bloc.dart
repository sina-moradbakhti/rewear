import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/shouldUpdateProfile.modal.dart';
import 'package:rewear/models/mainNavItem.enum.dart';
import 'package:rewear/models/userType.enum.dart';

class HomeBloc extends GetxController {
  TabController? controller;
  var currentTab = MainNavItem.home.obs;
  AppInit app = AppInit();

  @override
  void onInit() {
    _checkIsUpdatedProfile();
    super.onInit();
  }

  void changeTab(MainNavItem item) {
    currentTab.value = item;
    switch (item) {
      case MainNavItem.home:
        controller?.animateTo(0);
        break;
      case MainNavItem.tailorsNearby:
        controller?.animateTo(1);
        break;
      case MainNavItem.profile:
        controller?.animateTo(2);
        break;
    }
  }

  void _checkIsUpdatedProfile() {
    if (app.user.role == UserType.seller &&
        (app.user.phone == null ||
            app.user.address == null ||
            app.user.position == null)) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.dialog(const ShouldUpdateProfileDialog(),
            useSafeArea: true,
            barrierColor: Colors.black87,
            transitionCurve: Curves.easeInOut);
      });
    }
  }
}
