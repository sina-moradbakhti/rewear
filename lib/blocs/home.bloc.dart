import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/shouldUpdateProfile.modal.dart';
import 'package:rewear/models/mainNavItem.enum.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/services/update_profile.dart';

class HomeBloc extends GetxController {
  TabController? controller;
  var currentTab = MainNavItem.home.obs;
  AppInit app = AppInit();
  RxString currentCity = ''.obs;

  @override
  void onInit() {
    _checkIsUpdatedProfile();
    _updateLocation();
    if (app.user.city == null || app.user.country == null) {
      currentCity.value = "Locating..";
    } else {
      currentCity.value = '${app.user.city}, ${app.user.country}';
    }
    super.onInit();
  }

  _updateLocation() async {
    final permit = await app.getMyLocation();
    if (permit == false) {
      currentCity.value = "Permission denied";
    } else {
      if (app.user.city == null || app.user.country == null) {
        currentCity.value = "Locating..";
      } else {
        currentCity.value = '${app.user.city}, ${app.user.country}';
        final updateUserService = UpdateProfileService();
        updateUserService.call(city: app.user.city, country: app.user.country);
      }
    }
  }

  grantPermission() async {
    if (app.user.city == null || app.user.country == null) {
      await _updateLocation();
    }
  }

  void changeTab(MainNavItem item) {
    currentTab.value = item;
    switch (item) {
      case MainNavItem.home:
        controller?.animateTo(0);
        break;
      case MainNavItem.orders:
        controller?.animateTo(1);
        break;
      case MainNavItem.store:
        controller?.animateTo(2);
        break;
      case MainNavItem.profile:
        controller?.animateTo(3);
        break;
    }
  }

  void _checkIsUpdatedProfile() {
    if (app.user.role == UserType.seller &&
        (app.user.phone == null ||
            app.user.address == null ||
            app.user.position == null)) {
      List<String> emptyList = [];
      if (app.user.phone == null) emptyList.add('Phone number');
      if (app.user.address == null) emptyList.add('Address');
      if (app.user.position == null) emptyList.add('Location');

      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.dialog(
          ShouldUpdateProfileDialog(emptyList: emptyList),
          useSafeArea: true,
          barrierColor: Colors.black87,
          transitionCurve: Curves.easeInOut,
        );
      });
    }
  }
}
