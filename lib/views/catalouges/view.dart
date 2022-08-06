import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/search.bloc.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Catalogues extends StatelessWidget {
  Catalogues({Key? key}) : super(key: key);

  final bloc = Get.put(SearchBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(
          MyStrings.catalogues_title,
          style: Get.theme.textTheme.headline5,
        ),
      ),
      body: SafeArea(bottom: false, child: Container()),
    );
  }
}
