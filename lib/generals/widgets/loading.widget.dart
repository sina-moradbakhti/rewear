import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';

class MyLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const MyLoading({Key? key, this.size = 30, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
          color: color ?? MyColors.orange, strokeWidth: 1.5),
    );
  }
}
