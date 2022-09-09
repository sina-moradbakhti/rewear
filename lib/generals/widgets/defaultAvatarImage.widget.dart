import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/images.dart';

class DefaultAvatarImageWidget extends StatelessWidget {
  const DefaultAvatarImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60,
        height: 60,
        child: Container(
            decoration: BoxDecoration(color: MyColors.orange),
            child: Image.asset(MyImages.circularRewearLogo)));
  }
}
