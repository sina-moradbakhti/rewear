import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/modals/congrats.modal.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/order.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/services/firestorage.services.dart';
import 'package:rewear/services/firestore.services.dart';

class AlterationBloc extends GetxController {
  Rx<String> description = ''.obs;
  Rx<NeckStyle> selectedNeckStyle = NeckStyle.style0.obs;
  Rx<String> selectedMaterial = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Color? selectedColor = Colors.green;
  List<XFile> photos = [];
  RxBool creatingAnOrderLoading = false.obs;

  final app = AppInit();

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

  bool checkNotEmptyFields() {
    if (selectedMaterial.value == '') {
      app.handleError(MyErrorException(
          message: 'You have to choose a material for your cloth',
          title: 'Material Clothing'));
      return false;
    }
    if (selectedDate.value == null) {
      app.handleError(MyErrorException(
          message:
              'You have to choose a date, as you want this order to be done',
          title: 'Date'));
      return false;
    }
    if (photos.isEmpty) {
      app.handleError(MyErrorException(
          message: 'You have to select a photo at least', title: 'Photos'));
      return false;
    }
    return true;
  }

  void next() async {
    if (!checkNotEmptyFields()) return;
    creatingAnOrderLoading.value = true;
    await app.updateLastLocation(firestoreUpdate: false);

    if (app.currentPosition != null) {
      Order order =
          Order(id: '', userId: app.user.uid!, createdAt: DateTime.now());
      order.color = selectedColor;
      order.material = selectedMaterial.value;
      order.deliveryDate = selectedDate.value;
      order.neckStyle = selectedNeckStyle.value;
      order.description = description.value;
      order.images = [];
      order.serviceType = 'Alteration';

      final request = Request(
          order: order, customerId: app.user.uid!, orderDate: DateTime.now());

      try {
        final docId =
            await FirestoreServices().addRequests(request.toJsonForFirestore());
        request.docId = docId;

        for (final photo in photos) {
          final uploadedPhoto = await StorageServices().putDataForOrder(
              File(photo.path), StorageServices().generateRandomId(), docId);
          order.images!.add(uploadedPhoto);
        }

        await FirestoreServices()
            .updateRequests(request.toJsonForFirestore(), docId);

        // Go to choose a tailor
        Get.toNamed(MyRoutes.tailorsNearby, arguments: request);
        creatingAnOrderLoading.value = false;
      } catch (er) {
        Get.back();
        app.handleError(er);
      }
    }
  }
}
