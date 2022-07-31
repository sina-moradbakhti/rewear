import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:rewear/config/app_init.dart';

class StorageServices {
  static final StorageServices _singleton = StorageServices._internal();
  factory StorageServices() {
    return _singleton;
  }
  StorageServices._internal();

  Future<String> putCoverOrAvatar(File file, String name) async {
    final res = await FirebaseStorage.instance
        .ref('users/${AppInit().user.docId ?? ''}/$name')
        .putFile(file);

    return res.ref.getDownloadURL();
  }

  Future<String> putData(File file, String name) async {
    final res = await FirebaseStorage.instance
        .ref('users/${AppInit().user.docId ?? ''}/orders/$name')
        .putFile(file);

    return res.ref.getDownloadURL();
  }
}
