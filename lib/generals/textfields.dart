import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class MyTextfield extends StatelessWidget {
  final String title;
  MyTextfield({Key? key, required this.title}) : super(key: key);

  final _style = TextStyle(
      height: 1.4,
      fontSize: 12,
      color: MyColors.black,
      fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5, left: 2.5),
            child: Text(
              title,
              style: _style.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              style: _style.copyWith(fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintStyle: _style.copyWith(
                    fontWeight: FontWeight.w400,
                    color: MyColors.grey,
                    fontSize: 13),
              ),
            ),
          )
        ],
      ),
    );
  }
}
