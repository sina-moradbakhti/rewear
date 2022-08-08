import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/mainNavItem.enum.dart';
import 'package:rewear/models/userType.enum.dart';

class HomeNavbar extends StatelessWidget {
  HomeNavbar({Key? key}) : super(key: key);

  final _bloc = Get.find<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(width: 1.25, color: MyColors.grey))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeNavbarItem(
                      isSelected: _bloc.currentTab.value == MainNavItem.home,
                      title: 'Home',
                      icon: IconlyFont.home,
                      onTapped: () => _bloc.changeTab(MainNavItem.home)),
                  AppInit().user.role! == UserType.customer
                      ? StreamBuilder(
                          stream: AppInit().requestsStream,
                          builder: ((context, snapshot) => HomeNavbarItem(
                              badge: AppInit()
                                  .requests
                                  .where((req) =>
                                      (!req.seen && req.acceptedBySeller))
                                  .toList()
                                  .isNotEmpty,
                              isSelected:
                                  _bloc.currentTab.value == MainNavItem.orders,
                              title: 'Orders',
                              icon: IconlyFont.discovery,
                              onTapped: () =>
                                  _bloc.changeTab(MainNavItem.orders))))
                      : HomeNavbarItem(
                          isSelected:
                              _bloc.currentTab.value == MainNavItem.orders,
                          title: 'Catalogue',
                          icon: MySvgs.book,
                          onTapped: () => _bloc.changeTab(MainNavItem.orders)),
                  HomeNavbarItem(
                      isSelected: _bloc.currentTab.value == MainNavItem.profile,
                      title: 'Profile',
                      icon: IconlyFont.profile,
                      onTapped: () => _bloc.changeTab(MainNavItem.profile))
                ])),
      ),
    );
  }
}

class HomeNavbarItem extends StatelessWidget {
  final bool isSelected;
  final dynamic icon;
  final String title;
  final VoidCallback onTapped;
  final bool badge;
  const HomeNavbarItem(
      {Key? key,
      this.isSelected = false,
      required this.icon,
      required this.title,
      required this.onTapped,
      this.badge = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: MyColors.lightOrange,
                borderRadius: BorderRadius.circular(30))
            : const BoxDecoration(),
        child: isSelected
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon.runtimeType.toString() == 'IconData'
                          ? Icon(icon, color: MyColors.orange, size: 20)
                          : SvgPicture.asset(icon, color: MyColors.orange),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(title,
                            style: Get.theme.textTheme.bodyText1!
                                .copyWith(color: MyColors.orange)),
                      )
                    ]),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          icon.runtimeType.toString() == 'IconData'
                              ? Icon(icon, size: 20)
                              : SvgPicture.asset(icon),
                          if (badge)
                            Positioned(
                                top: 5,
                                left: -15,
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: MyColors.orange,
                                ))
                        ],
                      ),
                      Text(
                        title,
                        style: Get.theme.textTheme.bodyText1,
                      )
                    ]),
              ),
      ),
    );
  }
}
