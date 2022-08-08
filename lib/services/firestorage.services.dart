import 'dart:io';
import 'dart:math';
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

  Future<String> putDataForOrder(File file, String name, String orderId) async {
    final res = await FirebaseStorage.instance
        .ref('users/${AppInit().user.docId ?? ''}/orders/$orderId/$name')
        .putFile(file);

    return res.ref.getDownloadURL();
  }

  String generateRandomId() {
    final rng = Random();
    var string = '';
    for (var i = 0; i < 10; i++) {
      string += rng.nextInt(10000).toString();
    }
    return string;
  }
}
