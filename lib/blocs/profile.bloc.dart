import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/modals/updateTailorLocation.modal.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/generals/exts/extensions.dart';
import 'package:rewear/services/update_profile.dart';

class ProfileBloc extends GetxController {
  RxBool loading = false.obs;
  RxBool coordinatingLocation = false.obs;
  RxBool locationIsSet = false.obs;
  Rx<XFile?> selectedFile = Rx<XFile?>(null);
  Rx<XFile?> selectedCoverFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  AppInit app = AppInit();

  final services = UpdateProfileService();

  @override
  void onInit() {
    locationIsSet.value = (app.user.position != null);
    super.onInit();
  }

  void coordinateLocation() async {
    coordinatingLocation.value = true;
    if (app.user.position == null) {
      await app.updateLastLocation(isBackground: false);
    }
    Get.dialog(
      UpdateTailorLocationDialog(onReturnLocation: _setNewLocation),
      useSafeArea: true,
      barrierColor: Colors.black87,
      transitionCurve: Curves.easeInOut,
    );
    coordinatingLocation.value = false;
  }

  _setNewLocation(LatLng? newLocation) async {
    if (newLocation == null) return;

    await services.call(
        position: '${newLocation.latitude},${newLocation.longitude}');

    if (app.user.position == null) return;
    locationIsSet.value = true;
  }

  ImageProvider getProfileAvatar() {
    if (selectedFile.value == null) {
      if (app.user.image != null) {
        return NetworkImage(app.user.image!.avatarURL());
      }
      return const AssetImage(MyImages.defaultProfile);
    }
    return FileImage(File(selectedFile.value!.path));
  }

  ImageProvider? getProfileCover() {
    if (selectedCoverFile.value == null) {
      if (app.user.cover != null) {
        return NetworkImage(app.user.cover!.coverURL());
      }
      return null;
    }
    return FileImage(File(selectedCoverFile.value!.path));
  }

  void uploadProfile() async {
    selectedFile.value = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 300,
        maxWidth: 300);
  }

  void uploadCover() async {
    selectedCoverFile.value = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 70, maxHeight: 400);
  }

  void updateInfo() async {
    loading.value = true;

    try {
      await services.call(
          fullname: app.user.fullname,
          image: selectedFile.value?.path,
          cover: selectedCoverFile.value?.path,
          address: app.user.address,
          description: app.user.description,
          phone: app.user.phone,
          position: app.user.position != null
              ? '${app.user.position!.latitude},${app.user.position!.longitude}'
              : null,
          slogan: app.user.slogan);

      loading.value = false;
      app.handleError(MyErrorException(
          title: 'Updated Successfully',
          message: 'your profile information updated.'));
    } catch (er) {
      debugPrint('$er');
      loading.value = false;
      app.handleError(er);
    }
  }
}
