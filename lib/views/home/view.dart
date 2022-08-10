import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/widgets/homeAppbar.widget.dart';
import 'package:rewear/generals/widgets/homeNavbar.widget.dart';
import 'package:rewear/models/userType.enum.dart';
import 'package:rewear/views/findServices/view.dart';
import 'package:rewear/views/profile/view.dart';
import 'package:rewear/views/requests/tailor.view.dart';
import 'package:rewear/views/requests/view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _bloc = Get.put(HomeBloc());
  final _pages = [
    const FindServices(),
    AppInit().user.role == UserType.seller
        ? TailorRequests(showAppBar: false)
        : Requests(showAppBar: false),
    Profile()
  ];

  @override
  void initState() {
    _bloc.controller = TabController(length: _pages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppbar(),
        body: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _bloc.controller,
              children: _pages,
            ),
            Align(
              child: Container(
                  color: Colors.white, child: SafeArea(child: HomeNavbar())),
              alignment: Alignment.bottomCenter,
            )
          ],
        ));
  }
}
