import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_core/firebase_core.dart' as fbCore;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/errorException.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  static const String BASE_URL = 'https://asbrothers.ca';
  static const String TERMS_CONDITION_URL = 'https://asbrothers.ca/terms';
  static const String PRIVACY_POLICY_URL = 'https://asbrothers.ca/privacy';

  fbCore.FirebaseApp? firebaseApp;

  bool isUserLoggedIn = false;
  User user = User();

  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.black,
    Colors.brown,
    Colors.white,
    Colors.grey
  ];

  final List<String> materials = [
    'Cotton',
    'Cellulosic fibres/viscose',
    'Wool',
    'Silk',
    'Leather',
    'Bast fibres',
    'Experimental fabrics',
    'Notions and hardware'
  ];
  final List<NeckStyleModel> neckStyles = [
    NeckStyleModel(
        clickedImage: MyImages.tShirt01,
        image: MyImages.tShirt01Grey,
        style: NeckStyle.style0),
    NeckStyleModel(
        clickedImage: MyImages.tShirt02,
        image: MyImages.tShirt02Grey,
        style: NeckStyle.style1),
    NeckStyleModel(
        clickedImage: MyImages.tShirt03,
        image: MyImages.tShirt03Grey,
        style: NeckStyle.style2),
    NeckStyleModel(
        clickedImage: MyImages.tShirt04,
        image: MyImages.tShirt04Grey,
        style: NeckStyle.style3)
  ];

  Future<void> preInit() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    firebaseApp = await fbCore.Firebase.initializeApp();

    // Check user is logged in or not
    user = User.fromCache();
    if (user.uid != null) {
      isUserLoggedIn = true;
    } else {
      isUserLoggedIn = false;
    }
  }

  void handleError(exception) {
    String title = '';
    String message = '';
    switch (exception.runtimeType) {
      case fbAuth.FirebaseException:
      case fbAuth.FirebaseAuthException:
        title =
            exception.code.toString().replaceAll('-', ' ').capitalizeFirst ??
                '';
        message = exception.message ?? '';
        break;
      case MyErrorException:
        title = exception.title;
        message = exception.message ?? '';
        break;
    }

    Get.snackbar(title, message,
        backgroundColor: MyColors.orange,
        colorText: MyColors.white,
        titleText: Text(
          title,
          style: Get.theme.textTheme.bodyText1!
              .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: Get.theme.textTheme.bodyText1!
              .copyWith(color: MyColors.white, fontWeight: FontWeight.normal),
        ));
  }

  Future<void> openLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
