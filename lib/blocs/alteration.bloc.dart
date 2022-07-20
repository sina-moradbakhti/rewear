import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';

class AlterationBloc extends GetxController {
  Rx<NeckStyle> selectedNeckStyle = NeckStyle.style0.obs;
  Rx<String> selectedMaterial = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Color? selectedColor;
  List<XFile> photos = [];

  void updateNeckStyle(NeckStyleModel model) {
    selectedNeckStyle.value = model.style;
  }

  String currentDateToStr() {
    print(selectedDate);
    if (selectedDate.value == null) {
      return '';
    } else {
      final d = selectedDate.value!;
      return '${d.year}-${d.month.toString().length <= 1 ? '0${d.month}' : d.month}-${d.day.toString().length <= 1 ? '0${d.day}' : d.day}';
    }
  }

  void chooseDate() async {
    DateTime? date = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    selectedDate.value = date;
  }

  void recordVoice() async {}

  void updatePhotoList(List<XFile> list) {
    photos = list;
  }

  void changedColor(Color color) {
    selectedColor = color;
  }
}
