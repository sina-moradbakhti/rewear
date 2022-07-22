import 'package:flutter/material.dart';

class MyConstants {
  MyConstants._();
  static const primaryPadding =
      EdgeInsets.only(top: 32, bottom: 32, left: 24, right: 24);
  static const topDoublePadding = EdgeInsets.only(top: 30);
  static const topPadding = EdgeInsets.only(top: 15);
  static const topHalfPadding = EdgeInsets.only(top: 7.5);
  static const textfieldPadding =
      EdgeInsets.only(top: .5, bottom: .5, right: 10, left: 10);
  static final BorderRadius primaryCircularRadius = BorderRadius.circular(15);
  static final BorderRadius buttonCircularRadius = BorderRadius.circular(8);

  // Local cache ids
  static const String USER_IS_LOGIN_ID = '__lc__user__is_login';
  static const String USER_DATA_ID = '__lc__user__data';
}
