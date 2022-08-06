import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/services/firestorage.services.dart';
import 'package:rewear/services/firestore.services.dart';

class ProfileBloc extends GetxController {
  RxBool loading = false.obs;
  RxBool coordinatingLocation = false.obs;
  RxBool locationIsSet = false.obs;
  Rx<XFile?> selectedFile = Rx<XFile?>(null);
  Rx<XFile?> selectedCoverFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  AppInit app = AppInit();

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
      if (app.user.image != null) return NetworkImage(app.user.image!);
      return const AssetImage(MyImages.defaultProfile);
    }
    return FileImage(File(selectedFile.value!.path));
  }

  ImageProvider? getProfileCover() {
    if (selectedCoverFile.value == null) {
      if (app.user.cover != null) return NetworkImage(app.user.cover!);
      return null;
    }
    return FileImage(File(selectedCoverFile.value!.path));
  }

  void uploadProfile() async {
    selectedFile.value = await _picker.pickImage(source: ImageSource.gallery);
  }

  void uploadCover() async {
    selectedCoverFile.value =
        await _picker.pickImage(source: ImageSource.gallery);
  }

  void updateInfo() async {
    loading.value = true;

    try {
      if (selectedFile.value != null) {
        app.user.image = await StorageServices()
            .putCoverOrAvatar(File(selectedFile.value!.path), 'avatar');
      }

      if (selectedCoverFile.value != null) {
        app.user.cover = await StorageServices()
            .putCoverOrAvatar(File(selectedCoverFile.value!.path), 'cover');
      }

      await FirestoreServices().updateUserWithDocId(
          app.user.docId ?? '', app.user.toJsonForFirestore());

      await app.user.updateCache();

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
