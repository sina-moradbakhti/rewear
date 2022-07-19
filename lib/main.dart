import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/themes.dart';
import 'package:rewear/views/alteration/view.dart';
import 'package:rewear/views/forgotPassword/view.dart';
import 'package:rewear/views/home/view.dart';
import 'package:rewear/views/launchScreen/view.dart';
import 'package:rewear/views/login/view.dart';
import 'package:rewear/views/promotion/view.dart';
import 'package:rewear/views/redesign/view.dart';
import 'package:rewear/views/repair/view.dart';
import 'package:rewear/views/signUp/view.dart';
import 'package:rewear/views/welcomeScreen/view.dart';

void main() {
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
          GetPage(name: MyRoutes.launch, page: () => const LaunchScreen()),
          GetPage(name: MyRoutes.welcome, page: () => const WelcomeScreen()),
          GetPage(name: MyRoutes.signup, page: () => SignUp()),
          GetPage(name: MyRoutes.login, page: () => Login()),
          GetPage(name: MyRoutes.forgotPassword, page: () => ForgotPassword()),
          GetPage(name: MyRoutes.alteration, page: () => Alteration()),
          GetPage(name: MyRoutes.redesign, page: () => const Redesign()),
          GetPage(name: MyRoutes.repair, page: () => const Repair()),
          GetPage(name: MyRoutes.promotion, page: () => const Promotion()),
          GetPage(name: MyRoutes.home, page: () => const Home()),
        ],
        initialRoute: MyRoutes.home, // MyRoutes.launch
      ),
    );
  }
}
