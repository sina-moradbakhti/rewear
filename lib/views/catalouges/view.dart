import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/search.bloc.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/config/mock_data.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/strings.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/catalogItem.widget.dart';
import 'package:rewear/generals/widgets/customAppbar.widget.dart';

class Catalogues extends StatelessWidget {
  bool showAppBar = true;
  Catalogues({Key? key, this.showAppBar = true}) : super(key: key);

  final bloc = Get.put(SearchBloc());
  final double space = 15;

  @override
  Widget build(BuildContext context) {
    if (showAppBar) {
      return Scaffold(
        appBar: CustomAppbar(
          centerTitle: true,
          title: Text(
            MyStrings.catalogues_title,
            style: Get.theme.textTheme.headline5,
          ),
        ),
        body: SafeArea(bottom: false, child: _content),
      );
    } else {
      return Scaffold(
        body: SafeArea(bottom: false, child: _content),
      );
    }
  } // end build

  Widget get _title => !showAppBar
      ? Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 24, left: 24),
          child: Text(
            MyStrings.catalogues_title,
            style: Get.theme.textTheme.headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        )
      : Container();

  Widget get _content => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title,
            Padding(
                padding: MyConstants.primaryPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CatalogItemWidget(
                        onPressed: () => _routeToDetails(),
                        image: 'assets/images/jpg/sample-catalog-02.jpg'),
                    BreakWidget(size: space, vertical: true),
                    SizedBox(
                      height: 220,
                      child: Row(
                        children: [
                          Expanded(
                              child: CatalogItemWidget(
                                  onPressed: () => _routeToDetails(),
                                  fullWidth: false,
                                  fullHeight: true,
                                  image:
                                      'assets/images/jpg/sample-catalog-03.jpg')),
                          BreakWidget(size: space, vertical: false),
                          Expanded(
                              child: CatalogItemWidget(
                                  onPressed: () => _routeToDetails(),
                                  fullWidth: false,
                                  fullHeight: true,
                                  image:
                                      'assets/images/jpg/sample-catalog-06.jpg'))
                        ],
                      ),
                    ),
                    BreakWidget(size: space, vertical: true),
                    CatalogItemWidget(
                        onPressed: () => _routeToDetails(),
                        image: 'assets/images/jpg/sample-catalog-04.jpg'),
                    BreakWidget(size: space, vertical: true),
                    SizedBox(
                      height: 280,
                      child: CatalogItemWidget(
                          onPressed: () => _routeToDetails(),
                          image: 'assets/images/jpg/sample-catalog-07.jpg',
                          fullHeight: true),
                    ),
                    BreakWidget(size: 100, vertical: true),
                  ],
                ))
          ],
        ),
      );

  void _routeToDetails() {
    Get.toNamed(MyRoutes.catalogueDetails,
        arguments: MockData().tailories.last);
  }
}
