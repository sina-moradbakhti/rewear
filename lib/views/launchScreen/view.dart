import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/blocs/launch.bloc.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);
  final bloc = Get.put(LaunchBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                MyImages.circularRewearLogo,
                width: Get.width / 2,
                height: Get.width / 2,
              ),
              Padding(
                padding: EdgeInsets.only(top: (Get.width / 2) + 100),
                child: Obx(
                  () => bloc.loadingStatus.value
                      ? CircularProgressIndicator(
                          color: MyColors.white, strokeWidth: 1.5)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(
                                width: Get.size.width / 2,
                                child: MyPrimaryButton(
                                  onPressed: bloc.reInit,
                                  hasUnderline: true,
                                  title: 'Refresh Connection',
                                  color: MyColors.orange,
                                  textColor: Colors.white,
                                ))
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
