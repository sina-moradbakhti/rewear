import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/themes.dart';
import 'package:rewear/views/alteration/view.dart';
import 'package:rewear/views/catalogueDetails/view.dart';
import 'package:rewear/views/catalouges/view.dart';
import 'package:rewear/views/changePassword/view.dart';
import 'package:rewear/views/forgotPassword/view.dart';
import 'package:rewear/views/home/view.dart';
import 'package:rewear/views/launchScreen/view.dart';
import 'package:rewear/views/login/view.dart';
import 'package:rewear/views/profile/view.dart';
import 'package:rewear/views/promotion/view.dart';
import 'package:rewear/views/redesign/view.dart';
import 'package:rewear/views/repair/view.dart';
import 'package:rewear/views/requestDetails/tailor.view.dart';
import 'package:rewear/views/requestDetails/view.dart';
import 'package:rewear/views/requests/tailor.view.dart';
import 'package:rewear/views/requests/view.dart';
import 'package:rewear/views/search/view.dart';
import 'package:rewear/views/settings/view.dart';
import 'package:rewear/views/signUp/view.dart';
import 'package:rewear/views/signupWithGoogle/view.dart';
import 'package:rewear/views/tailorsNearby/view.dart';
import 'package:rewear/views/verificationCode/view.dart';
import 'package:rewear/views/welcomeScreen/view.dart';

void main() async {
  await AppInit().initLibs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        title: 'Rewear App',
        theme: MyThemes.primary,
        getPages: [
          GetPage(name: MyRoutes.launch, page: () => LaunchScreen()),
          GetPage(name: MyRoutes.welcome, page: () => WelcomeScreen()),
          GetPage(name: MyRoutes.signup, page: () => SignUp()),
          GetPage(
              name: MyRoutes.signupWithGoogle, page: () => SignUpWithGoogle()),
          GetPage(name: MyRoutes.login, page: () => Login()),
          GetPage(name: MyRoutes.forgotPassword, page: () => ForgotPassword()),
          GetPage(
              name: MyRoutes.verificationCode, page: () => VerificationCode()),
          GetPage(name: MyRoutes.changePassword, page: () => ChangePassword()),
          GetPage(name: MyRoutes.alteration, page: () => Alteration()),
          GetPage(name: MyRoutes.redesign, page: () => Redesign()),
          GetPage(name: MyRoutes.repair, page: () => Repair()),
          GetPage(name: MyRoutes.promotion, page: () => const Promotion()),
          GetPage(name: MyRoutes.home, page: () => const Home()),
          GetPage(name: MyRoutes.settings, page: () => Settings()),
          GetPage(name: MyRoutes.search, page: () => Search()),
          GetPage(name: MyRoutes.profile, page: () => Profile()),
          GetPage(name: MyRoutes.requests, page: () => Requests()),
          GetPage(name: MyRoutes.catalogues, page: () => Catalogues()),
          GetPage(
              name: MyRoutes.catalogueDetails, page: () => CatalogueDetails()),
          GetPage(name: MyRoutes.requestDetails, page: () => RequestDetails()),
          GetPage(name: MyRoutes.tailorRequests, page: () => TailorRequests()),
          GetPage(
              name: MyRoutes.tailorRequestDetails,
              page: () => TailorRequestDetails()),
          GetPage(
              name: MyRoutes.tailorsNearby, page: () => const TailorsNearby()),
        ],
        initialRoute: MyRoutes.launch, // MyRoutes.launch
      ),
    );
  }
}
