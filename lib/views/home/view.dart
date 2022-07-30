import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/home.bloc.dart';
import 'package:rewear/generals/widgets/homeAppbar.widget.dart';
import 'package:rewear/generals/widgets/homeNavbar.widget.dart';
import 'package:rewear/views/findServices/view.dart';
import 'package:rewear/views/profile/view.dart';
import 'package:rewear/views/tailorsNearby/view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final _bloc = Get.put(HomeBloc());
  final _pages = [const FindServices(), const TailorsNearby(), Profile()];

  @override
  void initState() {
    _bloc.controller = TabController(length: _pages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppbar(),
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
