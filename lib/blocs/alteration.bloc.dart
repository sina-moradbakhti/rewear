import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/order.dart';

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

  void recordVoice() async {
    final record = Record();
    bool status = await record.hasPermission();
    print('Record : $status');
  }

  void updatePhotoList(List<XFile> list) {
    photos = list;
  }

  void changedColor(Color color) {
    selectedColor = color;
  }

  void next() async {
    await AppInit().updateLastLocation(firestoreUpdate: true);
    if (AppInit().currentPosition != null) {
      Order order =
          Order(id: '', userId: AppInit().user.uid!, createdAt: DateTime.now());
      order.color = selectedColor;
      order.material = selectedMaterial.value;
      order.deliveryDate = selectedDate.value;
      order.neckStyle = selectedNeckStyle.value;
      Get.toNamed(MyRoutes.tailorsNearby, arguments: order);
    }
  }
}
