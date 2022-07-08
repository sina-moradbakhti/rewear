import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Rewear App',
      theme: MyThemes.primary,
      routes: {
        MyRoutes.launch: (context) => const LaunchScreen(),
        MyRoutes.welcome: (context) => const WelcomeScreen(),
        MyRoutes.signup: (context) => const SignUp()
      },
      initialRoute: MyRoutes.welcome,
    );
  }
}
