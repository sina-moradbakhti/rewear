import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rewear/models/mainNavItem.enum.dart';

class HomeBloc extends GetxController {
  TabController? controller;
  var currentTab = MainNavItem.home.obs;

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
}
