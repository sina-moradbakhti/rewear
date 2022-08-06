import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/search.bloc.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Requests extends StatelessWidget {
  Requests({Key? key}) : super(key: key);

  final bloc = Get.put(SearchBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(
          MyStrings.requests_title,
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: SafeArea(bottom: false, child: Container()),
    );
  }
}
