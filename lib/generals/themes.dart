import 'package:flutter/material.dart';
import 'package:ms_material_color/ms_material_color.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class MyThemes {
  MyThemes._();
  static ThemeData primary = ThemeData(
      primarySwatch: MsMaterialColor(MyColors.orange.value),
      backgroundColor: MyColors.white,
      scaffoldBackgroundColor: MyColors.white,
      dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: MyColors.lightGrey,
          contentPadding: MyConstants.textfieldPadding,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.grey, width: .5),
              borderRadius: MyConstants.buttonCircularRadius),
          border: OutlineInputBorder(
              borderRadius: MyConstants.buttonCircularRadius)),
      textTheme: TextTheme(
          headline1: CustomTextStyles.headline,
          headline2: CustomTextStyles.headline.copyWith(
              fontSize: 60, letterSpacing: -0.5, fontWeight: FontWeight.normal),
          headline3: CustomTextStyles.headline.copyWith(
              fontSize: 48, letterSpacing: 0, fontWeight: FontWeight.normal),
          headline4: CustomTextStyles.headline.copyWith(
              fontSize: 34, letterSpacing: 0.25, fontWeight: FontWeight.normal),
          headline5: CustomTextStyles.headline.copyWith(
              fontSize: 24, letterSpacing: 0, fontWeight: FontWeight.normal),
          headline6: CustomTextStyles.headline.copyWith(
              fontSize: 20, letterSpacing: 0.15, fontWeight: FontWeight.w400),
          subtitle1: CustomTextStyles.subTitle,
          subtitle2: CustomTextStyles.subTitle.copyWith(
              fontSize: 14, letterSpacing: 0.1, fontWeight: FontWeight.w400),
          bodyText1: CustomTextStyles.body,
          bodyText2: CustomTextStyles.body.copyWith(
              fontSize: 14, letterSpacing: 0.25, fontWeight: FontWeight.normal),
          button: CustomTextStyles.button,
          overline: CustomTextStyles.overline),
      fontFamily: 'Roboto');
}

class CustomTextStyles {
  static TextStyle headline = TextStyle(
      height: 1.4,
      letterSpacing: -1.5,
      fontSize: 96,
      color: MyColors.black,
      fontWeight: FontWeight.w100);
  static TextStyle subTitle = TextStyle(
      height: 1.4,
      letterSpacing: 0.15,
      fontSize: 16,
      color: MyColors.black,
      fontWeight: FontWeight.normal);
  static TextStyle caption = TextStyle(
      height: 1.4,
      letterSpacing: 0.4,
      fontSize: 12,
      color: MyColors.black,
      fontWeight: FontWeight.normal);
  static TextStyle body = TextStyle(
      height: 1.4,
      letterSpacing: 0.5,
      fontSize: 16,
      color: MyColors.black,
      fontWeight: FontWeight.normal);
  static TextStyle button = TextStyle(
      height: 1.4,
      letterSpacing: 1.25,
      fontSize: 14,
      color: MyColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle overline = TextStyle(
      height: 1.4,
      letterSpacing: 1.5,
      fontSize: 10,
      color: MyColors.black,
      fontWeight: FontWeight.normal);
}
