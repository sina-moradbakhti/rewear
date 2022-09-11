import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/services/requests.dart';
import 'package:record/record.dart';

class ServiceBloc extends GetxController {
  final record = Record();

  Rx<String> description = ''.obs;
  Rx<NeckStyle> selectedNeckStyle = NeckStyle.style0.obs;
  Rx<String> selectedMaterial = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Color? selectedColor = Colors.green;
  List<XFile> photos = [];
  RxBool creatingAnOrderLoading = false.obs;
  var isRecordingVoice = false.obs;
  var recordedAudioPath = ''.obs;
  String serviceType = 'Alteration';

  final services = RequestsServices();
  final app = AppInit();

  ServiceBloc({required this.serviceType});

  @override
  void onInit() {
    _initRecorder();
    super.onInit();
  }

  _initRecorder() async {}

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

  void startRecordVoice() async {
    try {
      if (await record.hasPermission()) {
        await record.start();
        isRecordingVoice.value = true;
      } else {
        app.handleError(MyErrorException(
            message:
                'Microphone permission not granted, you can grant permission from your settings',
            title: 'Microphone Permission'));
      }
    } catch (er) {
      debugPrint('error while recording voice $er');
    }
  }

  void removeRecordedVoice() {
    recordedAudioPath.value = '';
  }

  void stopVoiceRecording() async {
    final path = await record.stop();
    isRecordingVoice.value = false;
    recordedAudioPath.value = path ?? '';
    debugPrint('Voice recording has been stoped! ($path)');
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
    await app.updateLastLocation();
    if (app.currentPosition != null) {
      final request = Request(
        deliveryToTailor: selectedDate.value!,
        customer: app.user,
        orderDate: DateTime.now(),
        color: selectedColor,
        material: selectedMaterial.value,
        neckStyle: selectedNeckStyle.value,
        description: description.value,
        images: [],
        serviceType: serviceType,
      );

      try {
        final reqId = await services.newRequest(request);
        if (reqId != null) {
          List<String> mustUpload = [];
          for (final photo in photos) {
            mustUpload.add(photo.path);
          }
          final uploadedImageList =
              await services.uploadResources(reqId: reqId, images: mustUpload);

          await services.updateRequestImages(
              images: uploadedImageList ?? [], reqId: reqId);
        }
        // Go to choose a tailor
        Get.toNamed(MyRoutes.tailorsNearby, arguments: reqId);
        creatingAnOrderLoading.value = false;
      } catch (er) {
        print(er);
        Get.back();
        app.handleError(er);
      }
    } else {
      app.handleError(MyErrorException(
          message:
              'To create an order you have to turn on your Location Service, then we are able to show you tailors nearby.',
          title: 'Location Service'));
    }
    creatingAnOrderLoading.value = false;
  }
}
