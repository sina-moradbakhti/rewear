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
        titleLarge: TextStyle(
            height: 1.4,
            fontSize: 20,
            color: MyColors.black,
            fontWeight: FontWeight.w400),
        titleSmall: TextStyle(
            height: 1.4,
            fontSize: 13,
            color: MyColors.black,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            height: 1.4,
            fontSize: 14,
            color: MyColors.lightBlack,
            fontWeight: FontWeight.w600),
      ),
      fontFamily: 'Roboto');
}
