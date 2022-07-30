import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/services/firestore.services.dart';

class ProfileBloc extends GetxController {
  RxBool loading = false.obs;
  Rx<XFile?> selectedFile = Rx<XFile?>(null);
  Rx<XFile?> selectedCoverFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  AppInit app = AppInit();

  ImageProvider getProfileAvatar() {
    if (selectedFile.value == null) {
      return const AssetImage(MyImages.defaultProfile);
    }
    return FileImage(File(selectedFile.value!.path));
  }

  ImageProvider? getProfileCover() {
    if (selectedCoverFile.value == null) {
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
    FirestoreServices().updateUserWithDocId(
        app.user.docId ?? '', app.user.toJsonForFirestore());
    loading.value = false;
    app.handleError(MyErrorException(title: 'Updated Successfully', message: 'your profile information updated.'));
  }
}
