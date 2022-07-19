import 'package:flutter/material.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/neckStyle.enum.dart';
import 'package:rewear/models/neckStyle.model.dart';
import 'package:rewear/models/user.dart';
import 'package:rewear/models/userType.enum.dart';

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  User user = User(
      id: "",
      fullname: "Sina Moradbakhti",
      email: "sina_moradbakhti@yahoo.com",
      role: UserType.customer);

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
}
