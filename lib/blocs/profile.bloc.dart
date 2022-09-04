import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/services/http.services.dart';
import 'package:rewear/generals/exts/extensions.dart';

class ProfileBloc extends GetxController {
  RxBool loading = false.obs;
  RxBool coordinatingLocation = false.obs;
  RxBool locationIsSet = false.obs;
  Rx<XFile?> selectedFile = Rx<XFile?>(null);
  Rx<XFile?> selectedCoverFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  AppInit app = AppInit();

  final services = HttpServices();

  void coordinateLocation() async {
    coordinatingLocation.value = true;
    await AppInit().updateLastLocation(isBackground: false);
    if (AppInit().user.position != null) {
      locationIsSet.value = true;
    }
    coordinatingLocation.value = false;
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
      await services.updateProfile(
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
