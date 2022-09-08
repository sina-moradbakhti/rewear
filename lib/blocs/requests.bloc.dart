import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/helpRequests.moal.dart';

class RequestsBloc extends GetxController {
  final app = AppInit();

  void showHelp() {
    Get.dialog(
      const RequestHelpDialog(),
      useSafeArea: true,
      barrierColor: Colors.black87,
      transitionCurve: Curves.easeInOut,
    );
  }
}
