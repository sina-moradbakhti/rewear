import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';

class AlterationBloc extends GetxController {
  Rx<NeckStyle> selectedNeckStyle = NeckStyle.style0.obs;
  Rx<String> selectedMaterial = ''.obs;

  void updateNeckStyle(NeckStyleModel model) {
    selectedNeckStyle.value = model.style;
  }

  void chooseDate() {}

  void recordVoice() {}

  void changedColor(Color color) {
    print(color);
  }
}
