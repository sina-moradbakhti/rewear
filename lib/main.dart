import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/themes.dart';
import 'package:rewear/views/launchScreen/view.dart';
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
    return GetMaterialApp(
      title: 'Rewear App',
      theme: MyThemes.primary,
      getPages: [
        GetPage(name: MyRoutes.launch, page: () => const LaunchScreen()),
        GetPage(name: MyRoutes.welcome, page: () => const WelcomeScreen()),
        GetPage(name: MyRoutes.signup, page: () => const SignUp())
      ],
      initialRoute: MyRoutes.launch,
    );
  }
}
