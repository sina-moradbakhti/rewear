import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';

class MyTextfield extends StatelessWidget {
  final String title;
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final VoidCallback? onTappedSuffixIcon;

  const MyTextfield(
      {Key? key,
      required this.title,
      this.hint = '',
      this.isPassword = false,
      this.suffixIcon,
      this.suffixIcon2,
      this.onTappedSuffixIcon})
      : super(key: key);

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
              style: Get.theme.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 42.5,
            child: TextField(
              style: Get.theme.textTheme.bodyText2,
              decoration: InputDecoration(
                suffixIcon: Icon(suffixIcon),
                hintText: hint,
                hintStyle: Get.theme.textTheme.bodyText2
                    ?.copyWith(color: MyColors.darkGrey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
