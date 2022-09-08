import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/store.bloc.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/widgets/break.widget.dart';

class Store extends StatelessWidget {
  Store({Key? key}) : super(key: key);
  final bloc = Get.put(StoreBloc());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 30,
                left: MyConstants.primaryPadding.left,
                right: MyConstants.primaryPadding.right),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tanakora Store',
                      style: Get.theme.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  BreakWidget(
                    size: 10,
                    vertical: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "We love our planet, let's keep that clean by selling our used clothes as much as possible",
                      style: Get.theme.textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  BreakWidget(
                    size: 30,
                    vertical: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Publish soon",
                      style: Get.theme.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                  )
                ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Opacity(
                  opacity: 0.85,
                  child: SizedBox(
                      width: Get.size.width,
                      child: Image.asset(
                        MyImages.storeSoonBackground,
                        fit: BoxFit.contain,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
