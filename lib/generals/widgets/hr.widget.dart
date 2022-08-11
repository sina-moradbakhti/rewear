import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';

class Hr extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  const Hr({Key? key, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return padding != null
        ? Padding(
            padding: padding!,
            child: SizedBox(
              width: double.infinity,
              height: 0.5,
              child: Container(
                color: color ?? MyColors.grey,
              ),
            ))
        : SizedBox(
            width: double.infinity,
            height: 0.5,
            child: Container(
              color: color ?? MyColors.grey,
            ),
          );
  }
}
