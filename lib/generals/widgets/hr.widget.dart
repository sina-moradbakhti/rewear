import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';

class Hr extends StatelessWidget {
  const Hr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 0.5,
      child: Container(
        color: MyColors.grey,
      ),
    );
  }
}
